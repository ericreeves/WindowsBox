// for .net
// #r "D:\WMs\workspacer\install\workspacer.Shared.dll"
// #r "D:\WMs\workspacer\install\plugins\workspacer.Bar\workspacer.Bar.dll"
// #r "D:\WMs\workspacer\install\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
// #r "D:\WMs\workspacer\install\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"

// for .net core
#r "D:\WMs\workspacer\0.9.10\workspacer.Shared.dll"
#r "D:\WMs\workspacer\0.9.10\plugins\workspacer.Bar\workspacer.Bar.dll"
#r "D:\WMs\workspacer\0.9.10\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
#r "D:\WMs\workspacer\0.9.10\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"

// load custom csx files
#load "C:\Users\ScrewW10\.workspacer\custom\dwindle.csx"
#load "C:\Users\ScrewW10\.workspacer\custom\grid.csx"
#load "C:\Users\ScrewW10\.workspacer\custom\floating.csx"

using System;
using System.Collections.Generic;
using System.Linq;
using workspacer;
using workspacer.Bar;
using workspacer.Bar.Widgets;
using workspacer.ActionMenu;
using workspacer.FocusIndicator;
using System.Reflection;

Action<IConfigContext> doConfig = (context) =>
{
    Configure(context);
};

void SetLayoutEngines(IConfigContext context)
{
    context.DefaultLayouts = () => { return new ILayoutEngine[] { new TallLayoutEngine(), new FullLayoutEngine(), new DwindleLayoutEngine(), new GridLayoutEngine(), /*new FloatingLayoutEngine(15same as bar height)*/ }; };
}

void AddBar(IConfigContext context)
{
    context.AddBar(new BarPluginConfig()
    {
        BarTitle = "workspacer.Bar",
        BarHeight = 15,
        FontSize = 8,
        // FontName = "Font Awesome",
        DefaultWidgetBackground = new Color(35, 35, 35),
        DefaultWidgetForeground = new Color(60, 110, 113),
        Background = Color.White,
        LeftWidgets = () => new IBarWidget[] { new WorkspaceWidget() {
            WorkspaceHasFocusColor = new Color(185,45,30),
            WorkspaceEmptyColor = new Color(217,217,217),
            WorkspaceIndicatingBackColor  = new Color(185,45,30)
        }, new TextWidget(": "), new TitleWidget() },
        RightWidgets = () => new IBarWidget[] { new TimeWidget(), new ActiveLayoutWidget() },
    });
}

void AddFocusIndicator(IConfigContext context)
{
    context.AddFocusIndicator(new FocusIndicatorPluginConfig
    {
        BorderSize = 10, // is also a gap between windows ?
        BorderColor = new Color(185, 45, 30),
        TimeToShow = 120
    });
}

void SetCustomKeybinds(IConfigContext context)
{
    var mod = KeyModifiers.Alt;

    // all layouts are based on SetLayoutEngines defined order

    // mod+T switches to tall mode
    context.Keybinds.Unsubscribe(mod, Keys.T);
    context.Keybinds.Subscribe(mod, Keys.T, () =>
    {
        typeof(Workspace).GetField("_layoutIndex", BindingFlags.NonPublic | BindingFlags.Instance).SetValue(context.Workspaces.FocusedWorkspace, 0);
        context.Workspaces.FocusedWorkspace.DoLayout();
    });

    // mod+F switches to full mode
    context.Keybinds.Unsubscribe(mod, Keys.F);
    context.Keybinds.Subscribe(mod, Keys.F, () =>
    {
        typeof(Workspace).GetField("_layoutIndex", BindingFlags.NonPublic | BindingFlags.Instance).SetValue(context.Workspaces.FocusedWorkspace, 1);
        context.Workspaces.FocusedWorkspace.DoLayout();
    });

    // mod+Y switches to dwindle mode
    context.Keybinds.Unsubscribe(mod, Keys.Y);
    context.Keybinds.Subscribe(mod, Keys.Y, () =>
    {
        typeof(Workspace).GetField("_layoutIndex", BindingFlags.NonPublic | BindingFlags.Instance).SetValue(context.Workspaces.FocusedWorkspace, 2);
        context.Workspaces.FocusedWorkspace.DoLayout();
    });

    // mod+U switches to grid mode
    context.Keybinds.Unsubscribe(mod, Keys.U);
    context.Keybinds.Subscribe(mod, Keys.U, () =>
    {
        typeof(Workspace).GetField("_layoutIndex", BindingFlags.NonPublic | BindingFlags.Instance).SetValue(context.Workspaces.FocusedWorkspace, 3);
        context.Workspaces.FocusedWorkspace.DoLayout();
    });

    // this layout is too buggy at the moment
    // mod+G switches to floating mode (since we're using F for full)
    // context.Keybinds.Unsubscribe(mod, Keys.G);
    // context.Keybinds.Subscribe(mod, Keys.G, () =>
    // {
    //     typeof(Workspace).GetField("_layoutIndex", BindingFlags.NonPublic | BindingFlags.Instance).SetValue(context.Workspaces.FocusedWorkspace, 4);
    //     context.Workspaces.FocusedWorkspace.DoLayout();
    // });
}

void Configure(IConfigContext context)
{
    SetLayoutEngines(context);
    AddBar(context);
    AddFocusIndicator(context);
    var actionMenu = context.AddActionMenu();

    // context.WorkspaceContainer.CreateWorkspaces("1", "2", "3", "4", "5", "6", "7", "8", "9");
    var monitors = context.MonitorContainer.GetAllMonitors(); // 0, 1, 2 (max 3 monitors)
    var sticky = new StickyWorkspaceContainer(context, StickyWorkspaceIndexMode.Local);
    context.WorkspaceContainer = sticky;
    // create workspaces for each monitor 0:n - 1, 1:n - 2, 2:n - 3 monitor
    for (int i = 0; i < monitors.Length; i++)
    {
        sticky.CreateWorkspaces(monitors[i], $"{i}:1", $"{i}:2", $"{i}:3", $"{i}:4", $"{i}:5", $"{i}:6", $"{i}:7", $"{i}:8", $"{i}:9");
    }

    // ignore managing by workspacer
    var ignoredWindows = new string[] { "Steam", "Rainmeter", "Autocad" };
    context.WindowRouter.AddFilter((window) => !ignoredWindows.Any(iw => window.Title.Equals(iw)));

    // route apps to specific window
    context.WindowRouter.AddRoute((window) => window.Title.Contains("Skype") ? context.WorkspaceContainer["0:4"] : null); // 0:4 is the name of the {monitor}:{workspace}
    context.WindowRouter.AddRoute((window) => window.Title.Contains("NGENUITY") ? context.WorkspaceContainer["0:8"] : null);

    SetCustomKeybinds(context);
}
return doConfig;