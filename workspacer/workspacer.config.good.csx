#r "C:\Program Files\workspacer\workspacer.Shared.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.Bar\workspacer.Bar.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.TitleBar\workspacer.TitleBar.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.Gap\workspacer.Gap.dll"

using System;
using workspacer;
using workspacer.Bar;
using workspacer.Bar.Widgets;
using workspacer.ActionMenu;
using workspacer.FocusIndicator;
using workspacer.TitleBar;
using workspacer.Gap;

Action<IConfigContext> doConfig = (context) =>
{
    // Uncomment to switch update branch (or to disable updates)
    context.Branch = Branch.Unstable;

    var fontSize = 10;
    var fontFace = "CaskaydiaCove Nerd Font Bold";
    var taskBarSize = (int) (fontSize * 2.1);
    var defaultBgColor = new Color( 0x22, 0x25, 0x22);
    var gap = 20;

    var draculaBackground = new Color(0x1e, 0x20, 0x29);
    var draculaForeground = new Color(0xf8, 0xf8, 0xf2);
    var draculaComment = new Color(0x62, 0x72, 0xa4);
    var draculaCyan = new Color(0x8b, 0xe9, 0xfd);
    var draculaPurple = new Color(0xbd, 0x93, 0xf9);

    context.AddBar(new BarPluginConfig()
    {
        FontName = fontFace,
        FontSize = fontSize,
        BarHeight = taskBarSize,
        DefaultWidgetForeground = draculaForeground,
        DefaultWidgetBackground = draculaBackground,
        Background = draculaBackground,
        LeftWidgets = () => new IBarWidget[] {
            new TextWidget(" "),
            new WorkspaceWidget() {
                WorkspaceHasFocusColor = draculaPurple,
                WorkspaceEmptyColor = draculaComment,
                WorkspaceIndicatingBackColor = draculaCyan,
            },
            new TextWidget(" "),
            new TitleWidget() {
                IsShortTitle = true,
                MonitorHasFocusColor = draculaPurple,
            }
        },
        RightWidgets = () => new IBarWidget[] {
            new TimeWidget(200, "HH:mm:ss"),
            new TextWidget(" ["),
            new ActiveLayoutWidget(),
            new TextWidget("] "),
        }
    });

    context.AddGap(
        new GapPluginConfig()
        {
            InnerGap = gap,
            OuterGap = gap / 2,
            Delta = gap / 2,
        }
    );

    context.AddFocusIndicator(
        new FocusIndicatorPluginConfig()
        {
            BorderColor = draculaPurple,
            BorderSize = 2,
            TimeToShow = 1000,
        }
    );

    var titleBarPluginConfig = new TitleBarPluginConfig(
        new TitleBarStyle(
            showTitleBar: false,
            showSizingBorder: false
    ));
    context.AddTitleBar(titleBarPluginConfig);

    var actionMenu = context.AddActionMenu(new ActionMenuPluginConfig()
    {
        MenuHeight = taskBarSize,
        FontSize = fontSize,
        FontName = fontFace,
        Background = draculaBackground,
        Foreground = draculaForeground,
    });
    var subMenu = actionMenu.Create();

    // Sleep
    string sleepCmd;
    sleepCmd = "/C rundll32.exe powrprof.dll,SetSuspendState 0,1,0";
    // Lock Desktop
    string lockCmd;
    lockCmd = "/C rundll32.exe user32.dll,LockWorkStation";
    // Shutdown
    string shutdownCmd;
    shutdownCmd = "/C shutdown /s /t 0";
    // Restart
    string restartCmd;
    restartCmd = "/C shutdown /r /t 0";

    subMenu.Add("sleep", () => System.Diagnostics.Process.Start("CMD.exe", sleepCmd));
    subMenu.Add("lock desktop", () => System.Diagnostics.Process.Start("CMD.exe", lockCmd));
    subMenu.Add("shutdown", () => System.Diagnostics.Process.Start("CMD.exe", shutdownCmd));
    subMenu.Add("restart", () => System.Diagnostics.Process.Start("CMD.exe", restartCmd));

    actionMenu.DefaultMenu.AddMenu("log off", subMenu);

    // Set workspaces ( 1, 2, 3, 4, 5 )
    context.WorkspaceContainer.CreateWorkspaces("1", "2", "3", "4", "5", "6", "7", "8", "9", "0");
    context.CanMinimizeWindows = true; // false by default

    // Exclude Applications from being managed by workspacer (games & forced fullscreen apps)
    context.WindowRouter.AddFilter((window) => !window.Title.Contains("League of Legends"));
    context.WindowRouter.AddFilter((window) => !window.Title.Contains("Legends of Runeterra"));
    context.WindowRouter.AddFilter((window) => !window.Title.Contains("VALORANT"));
    context.WindowRouter.AddFilter((window) => !window.Title.Contains("Snip"));
    context.WindowRouter.AddFilter((window) => !window.Title.Contains("Picture-in-Picture"));
    context.WindowRouter.AddFilter((window) => !window.Title.Contains("Keybase"));

    context.WindowRouter.AddRoute((window) => window.Title.Contains("Ferdium") ? context.WorkspaceContainer["1"] : null);
    // context.WindowRouter.AddRoute((window) => window.Title.Contains("Terminal") ? context.WorkspaceContainer["2"] : null);
    context.WindowRouter.AddRoute((window) => window.Title.Contains("Google Chrome") ? context.WorkspaceContainer["3"] : null);
    context.WindowRouter.AddRoute((window) => window.Title.Contains("Microsoft Edge") ? context.WorkspaceContainer["3"] : null);
    context.WindowRouter.AddRoute((window) => window.Title.Contains("Visual Studio Code") ? context.WorkspaceContainer["4"] : null);

    // Keyboard Shortcuts
    var mod = KeyModifiers.Alt;

    string browserCmd;
    browserCmd = "/C start chrome";
    string browsernCmd;
    browsernCmd = "/C start chrome -incognito";
    string settingsCmd;
    settingsCmd = "/C start ms-settings:";

    // Alt + F = File Explorer
    context.Keybinds.Subscribe(mod, workspacer.Keys.F, () => System.Diagnostics.Process.Start("explorer.exe"), "open file explorer");
    // Alt + B = Chrome
    context.Keybinds.Subscribe(mod, workspacer.Keys.B, () => System.Diagnostics.Process.Start("CMD.exe", browserCmd), "open chrome");
    // Alt + Shift + N = Chrome (Incognito)
    context.Keybinds.Subscribe(mod | workspacer.KeyModifiers.Shift, workspacer.Keys.N, () => System.Diagnostics.Process.Start("CMD.exe", browsernCmd), "open chrome (incognito)");
    // Alt + Shift + Enter = Terminal
    context.Keybinds.Subscribe(mod | workspacer.KeyModifiers.Shift, workspacer.Keys.Enter, () => System.Diagnostics.Process.Start("wt.exe"), "open terminal");
    // Alt + S = Windows Settings
    context.Keybinds.Subscribe(mod, workspacer.Keys.S, () => System.Diagnostics.Process.Start("CMD.exe", settingsCmd), "open windows settings");
};
return doConfig;