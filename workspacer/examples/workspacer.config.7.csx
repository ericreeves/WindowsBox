#r "C:\Program Files\workspacer\workspacer.Shared.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.Bar\workspacer.Bar.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"

using System;
using workspacer;
using workspacer.Bar;
using workspacer.ActionMenu;
using workspacer.FocusIndicator;

using Key = workspacer.Keys;


Action<IConfigContext> doConfig = (context) =>
{

    var BarConfig = new BarPluginConfig();
    BarConfig.BarHeight = 20;
    BarConfig.FontSize = 12;
    BarConfig.FontName = "Victor Mono";
    BarConfig.DefaultWidgetBackground = new workspacer.Color(21, 35, 45);
    BarConfig.DefaultWidgetForeground = new workspacer.Color(249, 193, 15);
    context.AddBar(BarConfig);

    context.AddFocusIndicator();

    var ActionMenuConfig = new ActionMenuPluginConfig();
    ActionMenuConfig.KeybindKey = Key.H;
    context.AddActionMenu(ActionMenuConfig);

    context.WorkspaceContainer.CreateWorkspaces("Main", "Ref", "Media");

    context.Keybinds.UnsubscribeAll();
    KeyModifiers mod = KeyModifiers.Alt;


    // Top Row 

    context.Keybinds.Subscribe(mod, Key.Y,
       () => context.Windows.ToggleFocusedWindowTiling(), "toggle tiling for focused window");

    context.Keybinds.Subscribe(mod, Key.U,
    () => context.Workspaces.SwitchFocusedMonitor(0), "focus monitor 1");

    context.Keybinds.Subscribe(mod, Key.I,
        () => context.Workspaces.FocusedWorkspace.SwapFocusAndNextWindow(), "swap focus and next window");

    context.Keybinds.Subscribe(mod, Key.O,
        () => context.Workspaces.FocusedWorkspace.SwapFocusAndPreviousWindow(), "swap focus and previous window");

    context.Keybinds.Subscribe(mod, Key.P,
        () => context.Workspaces.SwitchFocusedMonitor(1), "focus monitor 2");

    // Top Row - Shifted

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Key.U,
        () => context.Workspaces.MoveFocusedWindowToMonitor(0), "move focused window to monitor 1");

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Key.P,
        () => context.Workspaces.MoveFocusedWindowToMonitor(1), "move focused window to monitor 2");

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Key.I,
        () => context.Workspaces.FocusedWorkspace.CloseFocusedWindow(), "close focused window");


    // Middle Row 

    context.Keybinds.Subscribe(mod, Key.J,
        () => context.Workspaces.FocusedWorkspace.ShrinkPrimaryArea(), "shrink primary area");

    context.Keybinds.Subscribe(mod, Key.K,
        () => context.Workspaces.FocusedWorkspace.FocusNextWindow(), "focus next window");

    context.Keybinds.Subscribe(mod, Key.L,
        () => context.Workspaces.FocusedWorkspace.FocusPreviousWindow(), "focus previous window");

    context.Keybinds.Subscribe(mod, Key.OemSemicolon,
        () => context.Workspaces.FocusedWorkspace.ExpandPrimaryArea(), "expand primary area");

    // Middle Row - shifted 

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Key.H,
       () => context.Keybinds.ShowKeybindDialog(), "open keybind window");

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Key.J,
       () => context.ToggleConsoleWindow(), "toggle debug console");

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Key.K,
       () => context.Windows.DumpWindowUnderCursorDebugOutput(), "dump debug info to console for window under cursor");

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Key.L,
       () => context.Windows.DumpWindowDebugOutput(), "dump debug info to console for all windows");

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Key.OemSemicolon,
       () => context.Workspaces.FocusedWorkspace.ResetLayout(), "reset layout");


    // Bottom Row

    context.Keybinds.Subscribe(mod, Key.N,
        () => context.Workspaces.FocusedWorkspace.NextLayoutEngine(), "next layout");

    context.Keybinds.Subscribe(mod, Key.M,
        () => context.Workspaces.SwitchToNextWorkspace(), "switch to next workspace");

    context.Keybinds.Subscribe(mod, Key.Oemcomma,
        () => context.Workspaces.SwitchToPreviousWorkspace(), "switch to previous workspace");

    
    context.Keybinds.Subscribe(mod, Key.OemBackslash,
        () => context.Workspaces.FocusedWorkspace.CloseFocusedWindow(), "close focused window");


    // Bottom Row - Shifted

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Key.M,
        () => context.Workspaces.MoveFocusedWindowToWorkspace(0), "switch focused window to workspace 1");

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Key.Oemcomma,
        () => context.Workspaces.MoveFocusedWindowToWorkspace(1), "switch focused window to workspace 2");

    context.Keybinds.Subscribe(mod | KeyModifiers.LShift, Key.OemPeriod,
        () => context.Workspaces.MoveFocusedWindowToWorkspace(2), "switch focused window to workspace 3");


    // MISC

  
    // --------------------------------

    
};
return doConfig;