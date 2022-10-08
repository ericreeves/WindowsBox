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

    context.AddBar(
        new BarPluginConfig()
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
        }
    );

    context.AddGap(
        new GapPluginConfig()
        {
            InnerGap = gap,
            OuterGap = gap / 2,
            Delta = gap / 2,
            // GapColor = draculaBackground,
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
        )
    );
    context.AddTitleBar(titleBarPluginConfig);

    var actionMenu = context.AddActionMenu(new ActionMenuPluginConfig()
    {
        MenuHeight = taskBarSize,
        FontSize = fontSize,
        FontName = fontFace,
        Background = draculaBackground,
        Foreground = draculaForeground,
        KeybindKey = Keys.X,
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
    context.CanMinimizeWindows = false; // false by default
    // context.DefaultLayouts = () => new ILayoutEngine[] { new FullLayoutEngine(), new TallLayoutEngine(), new VertLayoutEngine(), new HorzLayoutEngine(), new PaneLayoutEngine(), new DwindleLayoutEngine() };
    // context.DefaultLayouts = () => new ILayoutEngine[] { new PaneLayoutEngine() };
    /* Default layouts */
    Func<ILayoutEngine[]> defaultLayouts = () => new ILayoutEngine[]
    {
        new TallLayoutEngine(),
        new VertLayoutEngine(),
        new HorzLayoutEngine(),
        new FullLayoutEngine(),
        new DwindleLayoutEngine(),
    };

    context.DefaultLayouts = defaultLayouts;


    // Exclude Applications from being managed by workspacer (games & forced fullscreen apps)
    context.WindowRouter.AddFilter((window) => !window.Title.Contains("KensingtonWorks"));
    context.WindowRouter.AddFilter((window) => !window.Title.Contains("League of Legends"));
    context.WindowRouter.AddFilter((window) => !window.Title.Contains("Legends of Runeterra"));
    context.WindowRouter.AddFilter((window) => !window.Title.Contains("1Password"));
    context.WindowRouter.AddFilter((window) => !window.Title.Contains("VALORANT"));
    context.WindowRouter.AddFilter((window) => !window.Title.Contains("Snip"));
    context.WindowRouter.AddFilter((window) => !window.Title.Contains("Picture-in-Picture"));
    context.WindowRouter.AddFilter((window) => !window.Title.Contains("Keybase"));
    context.WindowRouter.AddFilter((window) => !window.Title.Equals("Wox"));
    context.WindowRouter.AddFilter((window) => !window.Title.Equals("Everything"));
    context.WindowRouter.AddFilter((window) => !window.Class.Equals("ApplicationFrameWindow"));
    context.WindowRouter.AddFilter((window) => !window.Title.Equals("MasterStartupHotkeys.ahk"));
    context.WindowRouter.AddFilter((window) => !window.Class.Equals("#32770")); // Deletion dialog
    context.WindowRouter.AddFilter((window) => !window.Class.Equals("OperationStatusWindow")); // Copying dialog
    context.WindowRouter.AddFilter((window) => !window.ProcessName.Equals("pinentry")); // Yubikey GPG
    context.WindowRouter.AddFilter((window) => !window.ProcessName.Equals("qemu-system-x86_64")); // Android Emulator
    context.WindowRouter.AddFilter((window) => !window.ProcessName.Equals("notepad")); // Notepad

    context.WindowRouter.AddRoute((window) => window.Title.Contains("Ferdium") ? context.WorkspaceContainer["1"] : null);
    context.WindowRouter.AddRoute((window) => window.Title.Contains("Terminal") ? context.WorkspaceContainer["2"] : null);
    context.WindowRouter.AddRoute((window) => window.Title.Contains("Google Chrome") ? context.WorkspaceContainer["3"] : null);
    context.WindowRouter.AddRoute((window) => window.Title.Contains("Microsoft Edge") ? context.WorkspaceContainer["3"] : null);
    context.WindowRouter.AddRoute((window) => window.Title.Contains("Visual Studio Code") ? context.WorkspaceContainer["4"] : null);


    context.Keybinds.UnsubscribeAll();
    var modAlt = KeyModifiers.Alt;
    var modControl = KeyModifiers.Control;
    var modShift = KeyModifiers.Shift;

    // Top Row 

    context.Keybinds.Subscribe(modAlt | modControl, Keys.Q, context.Quit, "quit workspacer");
    context.Keybinds.Subscribe(modAlt, Keys.Q, context.Restart, "restart workspacer");

    context.Keybinds.Subscribe(modAlt, Keys.T,
        () => context.Windows.ToggleFocusedWindowTiling(), "toggle tiling for focused window");

    context.Keybinds.Subscribe(modAlt, Keys.Y,
        () => context.Workspaces.SwitchFocusedMonitor(0), "focus monitor 1");

    context.Keybinds.Subscribe(modAlt, Keys.U,
        () => context.Workspaces.FocusedWorkspace.DecrementNumberOfPrimaryWindows(), "decrement # primary windows");

    context.Keybinds.Subscribe(modAlt, Keys.I,
        () => context.Workspaces.FocusedWorkspace.IncrementNumberOfPrimaryWindows(), "increment # primary windows");

    context.Keybinds.Subscribe(modAlt, Keys.O,
        () => context.Workspaces.SwitchFocusedMonitor(1), "focus monitor 2");

    context.Keybinds.Subscribe(modAlt, Keys.OemCloseBrackets,
        () => context.Workspaces.FocusedWorkspace.NextLayoutEngine(), "next layout");

    context.Keybinds.Subscribe(modAlt, Keys.OemOpenBrackets,
        () => context.Workspaces.FocusedWorkspace.PreviousLayoutEngine(), "previous layout");

    // Top Row - Shifted

    context.Keybinds.Subscribe(modAlt | modControl, Keys.U,
        () => context.Workspaces.MoveFocusedWindowToMonitor(0), "move focused window to monitor 1");

    context.Keybinds.Subscribe(modAlt | modControl, Keys.P,
        () => context.Workspaces.MoveFocusedWindowToMonitor(1), "move focused window to monitor 2");

    context.Keybinds.Subscribe(modAlt | modControl, Keys.I,
        () => context.Workspaces.FocusedWorkspace.CloseFocusedWindow(), "close focused window");


    // Middle Row 

    context.Keybinds.Subscribe(modAlt, Keys.H,
        () => context.Workspaces.FocusedWorkspace.ShrinkPrimaryArea(), "shrink primary area");

    context.Keybinds.Subscribe(modAlt, Keys.J,
        () => context.Workspaces.FocusedWorkspace.FocusNextWindow(), "focus next window");

    context.Keybinds.Subscribe(modAlt, Keys.K,
        () => context.Workspaces.FocusedWorkspace.FocusPreviousWindow(), "focus previous window");

    context.Keybinds.Subscribe(modAlt, Keys.L,
        () => context.Workspaces.FocusedWorkspace.ExpandPrimaryArea(), "expand primary area");

    context.Keybinds.Subscribe(modAlt, Keys.OemSemicolon,
        () => context.Workspaces.FocusedWorkspace.ResetLayout(), "reset layout");

    // Middle Row - shifted 

    context.Keybinds.Subscribe(modAlt | modControl, Keys.J,
        () => context.Workspaces.FocusedWorkspace.SwapFocusAndNextWindow(), "swap focus and next window");

    context.Keybinds.Subscribe(modAlt | modControl, Keys.K,
        () => context.Workspaces.FocusedWorkspace.SwapFocusAndPreviousWindow(), "swap focus and previous window");

    // context.Keybinds.Subscribe(modAlt | modControl | modControl, Keys.J,
    //     () => context.ToggleConsoleWindow(), "toggle debug console");

    // context.Keybinds.Subscribe(modAlt | modControl | modControl, Keys.K,
    //     () => context.Windows.DumpWindowUnderCursorDebugOutput(), "dump debug info to console for window under cursor");

    // context.Keybinds.Subscribe(modAlt | modControl | modControl, Keys.L,
    //     () => context.Windows.DumpWindowDebugOutput(), "dump debug info to console for all windows");


    // Bottom Row

    context.Keybinds.Subscribe(modAlt, Keys.OemPeriod,
        () => context.Workspaces.SwitchToNextWorkspace(), "switch to next workspace");

    context.Keybinds.Subscribe(modAlt, Keys.Oemcomma,
        () => context.Workspaces.SwitchToPreviousWorkspace(), "switch to previous workspace");

    context.Keybinds.Subscribe(modAlt, Keys.OemQuestion,
        () => context.Keybinds.ShowKeybindDialog(), "open keybind window");

    context.Keybinds.Subscribe(modAlt, Keys.C,
        () => context.Workspaces.FocusedWorkspace.CloseFocusedWindow(), "close focused window");


    // Bottom Row - Shifted

    // Alt+# Switches Workspaces
    context.Keybinds.Subscribe(modAlt, Keys.D1,
        () => context.Workspaces.SwitchToWorkspace(0), "switch to workspace 1");
    context.Keybinds.Subscribe(modAlt, Keys.D2,
        () => context.Workspaces.SwitchToWorkspace(1), "switch to workspace 2");
    context.Keybinds.Subscribe(modAlt, Keys.D3,
        () => context.Workspaces.SwitchToWorkspace(2), "switch to workspace 3");
    context.Keybinds.Subscribe(modAlt, Keys.D4,
        () => context.Workspaces.SwitchToWorkspace(3), "switch to workspace 4");
    context.Keybinds.Subscribe(modAlt, Keys.D5,
        () => context.Workspaces.SwitchToWorkspace(4), "switch to workspace 5");
    context.Keybinds.Subscribe(modAlt, Keys.D6,
        () => context.Workspaces.SwitchToWorkspace(5), "switch to workspace 6");
    context.Keybinds.Subscribe(modAlt, Keys.D7,
        () => context.Workspaces.SwitchToWorkspace(6), "switch to workspace 7");
    context.Keybinds.Subscribe(modAlt, Keys.D8,
        () => context.Workspaces.SwitchToWorkspace(7), "switch to workspace 8");
    context.Keybinds.Subscribe(modAlt, Keys.D9,
        () => context.Workspaces.SwitchToWorkspace(8), "switch to workspace 9");
    context.Keybinds.Subscribe(modAlt, Keys.D0,
        () => context.Workspaces.SwitchToWorkspace(9), "switch to workspace 0");

    // Alt+Shift+# Moves Window and Switches Workspaces
    context.Keybinds.Subscribe(modAlt | modControl, Keys.D1, () => 
        {
            context.Workspaces.MoveFocusedWindowToWorkspace(0);
            context.Workspaces.SwitchToWorkspace(0);
        });
    context.Keybinds.Subscribe(modAlt | modControl, Keys.D2, () => 
        {
            context.Workspaces.MoveFocusedWindowToWorkspace(1);
            context.Workspaces.SwitchToWorkspace(1);
        });
    context.Keybinds.Subscribe(modAlt | modControl, Keys.D3, () => 
        {
            context.Workspaces.MoveFocusedWindowToWorkspace(2);
            context.Workspaces.SwitchToWorkspace(2);
        });
    context.Keybinds.Subscribe(modAlt | modControl, Keys.D4, () => 
        {
            context.Workspaces.MoveFocusedWindowToWorkspace(3);
            context.Workspaces.SwitchToWorkspace(3);
        });
    context.Keybinds.Subscribe(modAlt | modControl, Keys.D5, () => 
        {
            context.Workspaces.MoveFocusedWindowToWorkspace(4);
            context.Workspaces.SwitchToWorkspace(4);
        });
    context.Keybinds.Subscribe(modAlt | modControl, Keys.D6, () => 
        {
            context.Workspaces.MoveFocusedWindowToWorkspace(5);
            context.Workspaces.SwitchToWorkspace(5);
        });
    context.Keybinds.Subscribe(modAlt | modControl, Keys.D7, () => 
        {
            context.Workspaces.MoveFocusedWindowToWorkspace(6);
            context.Workspaces.SwitchToWorkspace(6);
        });
    context.Keybinds.Subscribe(modAlt | modControl, Keys.D8, () => 
        {
            context.Workspaces.MoveFocusedWindowToWorkspace(7);
            context.Workspaces.SwitchToWorkspace(7);
        });
    context.Keybinds.Subscribe(modAlt | modControl, Keys.D9, () => 
        {
            context.Workspaces.MoveFocusedWindowToWorkspace(8);
            context.Workspaces.SwitchToWorkspace(8);
        });
    context.Keybinds.Subscribe(modAlt | modControl, Keys.D0, () => 
        {
            context.Workspaces.MoveFocusedWindowToWorkspace(9);
            context.Workspaces.SwitchToWorkspace(9);
        });

    string browserCmd;
    browserCmd = "/C start chrome";
    string browsernCmd;
    browsernCmd = "/C start chrome -incognito";
    string settingsCmd;
    settingsCmd = "/C start ms-settings:";

    // Keyboard Shortcuts
    // var mod = KeyModifiers.Alt;
    // Alt + F = File Explorer
    context.Keybinds.Subscribe(modAlt, Keys.F, () => System.Diagnostics.Process.Start("explorer.exe"), "open file explorer");
    // Alt + B = Chrome
    context.Keybinds.Subscribe(modAlt, Keys.B, () => System.Diagnostics.Process.Start("CMD.exe", browserCmd), "open chrome");
    // Alt + Shift + N = Chrome (Incognito)
    context.Keybinds.Subscribe(modAlt | workspacer.KeyModifiers.Shift, Keys.N, () => System.Diagnostics.Process.Start("CMD.exe", browsernCmd), "open chrome (incognito)");
    // Alt + Shift + Enter = Terminal
    context.Keybinds.Subscribe(modAlt | workspacer.KeyModifiers.Shift, Keys.Enter, () => System.Diagnostics.Process.Start("wt.exe"), "open terminal");
    // Alt + S = Windows Settings
    context.Keybinds.Subscribe(modAlt, Keys.S, () => System.Diagnostics.Process.Start("CMD.exe", settingsCmd), "open windows settings");
};
return doConfig;