#r "C:\Program Files\workspacer\workspacer.Shared.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.Bar\workspacer.Bar.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.FocusBorder\workspacer.FocusBorder.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.TitleBar\workspacer.TitleBar.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.Gap\workspacer.Gap.dll"

using System;
using workspacer;
using workspacer.Bar;
using workspacer.Bar.Widgets;
using workspacer.ActionMenu;
using workspacer.FocusIndicator;
using workspacer.FocusBorder;
using workspacer.TitleBar;
using workspacer.Gap;

return new Action<IConfigContext>((IConfigContext context) =>
{
	// Uncomment to switch update branch (or to disable updates)
	// context.Branch = Branch.Unstable;

    //* ******* *//
    //* THEMING *//
    //* ******* *//

	// var background      = new Color(0x1e, 0x20, 0x29);
    // var background      = new Color(39,  46,   62);
    
    var background      = new Color(33, 31, 43);
    var urgent          = new Color(191, 97,  106);
    var positive        = new Color(163, 190, 140);
    var warning         = new Color(235, 203, 139);
    // var foreground      = new Color(129, 161, 193); // default
    var foreground      = new Color(240, 240, 240);
    var foreground2     = new Color(180, 142, 173);
    var foreground3     = new Color(230,230,230);
    var foreground4     = new Color(229, 233, 240);
    // var alt_background  = new Color(86,  106, 116); // default
    var alt_background      = new Color(33, 31, 43);
    var alt_urgent      = new Color(191, 97,  106);
    var alt_positive    = new Color(163, 190, 140);
    var alt_warning     = new Color(235, 203, 139);
    var alt_foreground  = new Color(230,230,230);
    var alt_foreground2 = new Color(180, 142, 173);
    var alt_foreground3 = new Color(143, 188, 187);
    var alt_foreground4 = new Color(236, 239, 244);
    var transparencykey = new Color(12,12,12);
    var fontSize        = 10;
	// var fontName        = "CaskaydiaCove Nerd Font Bold";
	var fontName        = "OperatorMono Nerd Font";
    var barHeight       = 30;
    var gap             = 10;

    //* ************ *//
    //* FOCUS BORDER *//
    //* ************ *//

    context.AddFocusBorder(new FocusBorderPluginConfig()
    {
        BorderColor = foreground3,
        BorderSize = 5,
        Opacity = 0.8

    });


    //* *** *//
    //* BAR *//
    //* *** *//

    context.AddBar(new BarPluginConfig()
    {
        //* Bar config
        FontSize = fontSize,
        BarHeight = barHeight,
        FontName = fontName,
        DefaultWidgetBackground = background,
        DefaultWidgetForeground = foreground,
        IsTransparent = false,
        // TransparencyKey = transparencykey,
        Background = background,
        BarIsTop = false,
        BarReservesSpace = true,
        //BarMargin = 5,

        //* Left Widgets
        LeftWidgets = () => new IBarWidget[]
        {
            new ActiveLayoutWidget(),
            new TextWidget("|"), 
            new WorkspaceWidget()
            {
                WorkspaceHasFocusColor = positive,
                WorkspaceEmptyColor = alt_background,
                WorkspaceIndicatingBackColor =  urgent,
            },
            new TextWidget("  "), 
            new TitleWidget() 
            {
                WindowHasFocusColor = foreground3,
                IsShortTitle = true,
                NoWindowMessage = ""
            },
        },
        
        //* Right Widgets
        RightWidgets = () => new IBarWidget[]
        {
            new CpuPerformanceWidget() 
            {
                StringFormat = "" + "{0}%"  
            },
            new MemoryPerformanceWidget()
            {
                StringFormat = " " + "{0}%"  
            },
             new TextWidget(" "), 
             new BatteryWidget(),
             new TextWidget("  "),
             new TimeWidget(1000, "HH:mm dd/MM/yyyy"),
             new TextWidget(" "),
        }
    });


    //* **** *//
    //* GAPS *//
    //* **** *//

    var gapPlugin = context.AddGap(new GapPluginConfig() { InnerGap = gap, OuterGap = 2, Delta = 2});

    //* *********** *//
    //* ACTION MENU *//
    //* *********** *//
    var actionMenu = context.AddActionMenu(new ActionMenuPluginConfig()
    {
        RegisterKeybind = false,
        MenuHeight = barHeight,
        FontSize = fontSize,
        FontName = fontName,
        Background = background,
    });

    //* Action menu builder
    Func<ActionMenuItemBuilder> createActionMenuBuilder = () =>
    {
        var menuBuilder = actionMenu.Create();

        //* Workspacer functions
        menuBuilder.Add("View keybinds", () => context.Keybinds.ShowKeybindDialog());
        menuBuilder.Add("Enable/Disable Workspacer", () => context.Enabled = !context.Enabled);
        menuBuilder.Add("Restart Workspacer", () => context.Restart());
        menuBuilder.Add("Quit Workspacer", () => context.Quit());

        return menuBuilder;
    };
    var actionMenuBuilder = createActionMenuBuilder();


    //* ****** *//
    //* CONFIG *//
    //* ****** *//

    context.CanMinimizeWindows = true;
    context.ToggleConsoleWindow(); //disable console on startup


    //* ******* *//
    //* LAYOUTS *//
    //* ******* *//

    //* Define Layout list
    Func<ILayoutEngine[]> defaultLayouts = () => new ILayoutEngine[]
    {
        new DwindleLayoutEngine(1,0.65,0.03){
            Name = "dwindle"
            // Name = "侀"
        },
        new TallLayoutEngine(){
            Name = "tall"
            // Name = "﬿"
        },
        new VertLayoutEngine(){
            Name = "vert"
            // Name = "ﰧ"
        },
        new HorzLayoutEngine(){
            Name = "horz"
            // Name = "ﰦ"
        },
        new FullLayoutEngine(){
            Name = "full"
            // Name = ""
        },
        new FocusLayoutEngine(){
            Name = "focus"
            // Name = "頻"
        },
    };

    //*Assign layout list to config context
    context.DefaultLayouts = defaultLayouts;


    //* ********** *//
    //* WORKSPACES *//
    //* ********** *//
    
    //* Define list of workspace names and layouts
    (string, ILayoutEngine[])[] workspaces =
    {
        ("1", defaultLayouts()),
        ("2", defaultLayouts()),
        ("3", defaultLayouts()),
        ("4", defaultLayouts()),
        ("5", defaultLayouts()),
        ("6", defaultLayouts()),
        ("7", defaultLayouts()),
        ("8", defaultLayouts()),
        ("9", defaultLayouts()),
        ("0", defaultLayouts()),

        // ("  Chat", defaultLayouts()),
        // ("  Terminal", defaultLayouts()),
        // ("爵  Web", defaultLayouts()),
        // ("  Coding", defaultLayouts()),
        // ("  5",defaultLayouts()),
        // ("懶  Media", defaultLayouts()),
        // ("  7",defaultLayouts()),
        // ("  8",defaultLayouts()),
        // ("  9",defaultLayouts()),
        // ("  Games", defaultLayouts()),
    };
    
    //* Creates one workspace for each of the layouts defined above
    foreach ((string name, ILayoutEngine[] layouts) in workspaces)
    {
        context.WorkspaceContainer.CreateWorkspace(name, layouts);
    }


    //* ******* *//
    //* FILTERS *//
    //* ******* *//

    //* By executable name
    context.WindowRouter.AddFilter((window) => !window.ProcessFileName.Equals("1Password.exe"));
    context.WindowRouter.AddFilter((window) => !window.ProcessFileName.Equals("pinentry.exe"));
    context.WindowRouter.AddFilter((window) => !window.ProcessFileName.Equals("AltSnap.exe"));
    context.WindowRouter.AddFilter((window) => !window.ProcessFileName.Equals("PowerToys.PowerLauncher.exe"));
	context.WindowRouter.AddFilter((window) => !window.ProcessFileName.Equals("mmc.exe"));

    //* By process name
	context.WindowRouter.AddFilter((window) => !window.ProcessName.Equals("pinentry")); // Yubikey GPG
	context.WindowRouter.AddFilter((window) => !window.ProcessName.Equals("qemu-system-x86_64")); // Android Emulator
	context.WindowRouter.AddFilter((window) => !window.ProcessName.Equals("notepad")); // Notepad
	context.WindowRouter.AddFilter((window) => !window.ProcessName.Equals("SmoothScrollGUI"));
	context.WindowRouter.AddFilter((window) => !window.ProcessName.Equals("pinentry")); // Yubikey GPG
	context.WindowRouter.AddFilter((window) => !window.ProcessName.Equals("qemu-system-x86_64")); // Android Emulator
	context.WindowRouter.AddFilter((window) => !window.ProcessName.Equals("notepad")); // Notepad

    //* By window class
	context.WindowRouter.AddFilter((window) => !window.Class.Equals("ShellTrayWnd")); // Edge
    context.WindowRouter.AddFilter((window) => !window.Class.Equals("ShellTrayWnd"));
    context.WindowRouter.AddFilter((window) => !window.Class.Equals("OperationStatusWindow")); //Explorer File copy
    context.WindowRouter.AddFilter((window) => !window.Class.Equals("#32770")); //File Selector
	context.WindowRouter.AddFilter((window) => !window.Class.Equals("ApplicationFrameWindow"));
	context.WindowRouter.AddFilter((window) => !window.Class.Equals("#32770")); // Deletion dialog
	context.WindowRouter.AddFilter((window) => !window.Class.Equals("OperationStatusWindow")); // Copying dialog
	context.WindowRouter.AddFilter((window) => !window.Class.Equals("ApplicationFrameWindow"));
	context.WindowRouter.AddFilter((window) => !window.Class.Equals("TWizardForm")); // Deletion dialog
	context.WindowRouter.AddFilter((window) => !window.Class.Equals("#32770")); // Deletion dialog
	context.WindowRouter.AddFilter((window) => !window.Class.Equals("OperationStatusWindow")); // Copying dialog

    //* By window title (equals)
    context.WindowRouter.AddFilter((window) => !window.Title.Equals("Color Picker"));
	context.WindowRouter.AddFilter((window) => !window.Title.Equals("Wox"));
	context.WindowRouter.AddFilter((window) => !window.Title.Equals("Everything"));
	context.WindowRouter.AddFilter((window) => !window.Title.Equals("MasterStartupHotkeys.ahk"));
	context.WindowRouter.AddFilter((window) => !window.Title.Equals("Window Spy"));
	context.WindowRouter.AddFilter((window) => !window.Title.Equals("Wox"));
	context.WindowRouter.AddFilter((window) => !window.Title.Equals("Everything"));
	context.WindowRouter.AddFilter((window) => !window.Title.Equals("MasterStartupHotkeys.ahk"));

    //* By window title (contains)
	context.WindowRouter.AddFilter((window) => !window.Title.Contains("KensingtonWorks"));
	context.WindowRouter.AddFilter((window) => !window.Title.Contains("League of Legends"));
	context.WindowRouter.AddFilter((window) => !window.Title.Contains("Legends of Runeterra"));
	context.WindowRouter.AddFilter((window) => !window.Title.Contains("1Password"));
	context.WindowRouter.AddFilter((window) => !window.Title.Contains("VALORANT"));
	context.WindowRouter.AddFilter((window) => !window.Title.Contains("Snip"));
	context.WindowRouter.AddFilter((window) => !window.Title.Contains("Picture-in-Picture"));
	context.WindowRouter.AddFilter((window) => !window.Title.Contains("Keybase"));

    //* Map Applications to Workspaces
	// context.WindowRouter.AddRoute((window) => window.Title.Contains("Ferdium") ? context.WorkspaceContainer["1"] : null);
	// context.WindowRouter.AddRoute((window) => window.Title.Contains("Terminal") ? context.WorkspaceContainer["2"] : null);
	// context.WindowRouter.AddRoute((window) => window.Title.Contains("Google Chrome") ? context.WorkspaceContainer["3"] : null);
	// context.WindowRouter.AddRoute((window) => window.Title.Contains("Microsoft Edge") ? context.WorkspaceContainer["3"] : null);
	// context.WindowRouter.AddRoute((window) => window.Title.Contains("Visual Studio Code") ? context.WorkspaceContainer["4"] : null);


    //* *********** *//
    //* KEYBINDINGS *//
    //* *********** *//

Action setKeybindings = () =>
    {
        //* Keybinding setup

        // Declare modifiers and combos
        KeyModifiers altCtrl = KeyModifiers.Alt | KeyModifiers.Control;
        KeyModifiers altShift = KeyModifiers.Alt | KeyModifiers.Shift;
        KeyModifiers alt = KeyModifiers.Alt;

        // Initialize Keybind manager
        IKeybindManager manager = context.Keybinds;
        // declare variables
        var workspaces = context.Workspaces;

        // Disables all previous keybindings
        manager.UnsubscribeAll();

        //* Mouse bindings
        // Left click focuses monitor
        manager.Subscribe(MouseEvent.LButtonDown, () => workspaces.SwitchFocusedMonitorToMouseLocation());

        //* Workspace bindings
        // Automatic keybindings for workspaces 1-9
        foreach (IWorkspace workspace in context.WorkspaceContainer.GetWorkspaces(context.MonitorContainer.FocusedMonitor))
        {
            // Gets workspace index (first workspace is index 0)
            int i = context.WorkspaceContainer.GetWorkspaceIndex(workspace);
            // Winkey + numbers 1-9 switches to corresponding workspace (considering index+1)
            manager.Subscribe(alt, (Keys)(49 + i), () => workspaces.SwitchToWorkspace(workspace),                  "Switch to Workspace " + (i+1));
            // Winkey +Shift + numbers 1-9 moves focused window to corresponding workspace (considering index+1)
            manager.Subscribe(altCtrl, (Keys)(49 + i), () => workspaces.MoveFocusedWindowToWorkspace(i),           "Switch to Workspace " + (i+1));
        }

        // Workspace 0 is Special
		// Winkey + numbers 1-9 switches to corresponding workspace (considering index+1)
		manager.Subscribe(alt,      Keys.D0, () => workspaces.SwitchToWorkspace(9),                                "Switch to Workspace 0");
		// Winkey +Shift + numbers 1-9 moves focused window to corresponding workspace (considering index+1)
		manager.Subscribe(altCtrl,  Keys.D0, () => workspaces.MoveFocusedWindowToWorkspace(9),                     "Switch to Workspace 0");

        manager.Subscribe(alt,      Keys.Oemcomma, () => workspaces.SwitchToPreviousWorkspace(),                   "Switch to previous workspace");
        manager.Subscribe(alt,      Keys.OemPeriod, () => workspaces.SwitchToNextWorkspace(),                      "Switch to next workspace");

        // Winkey + Shift + Left/Right moves window to previous/next monitor
        manager.Subscribe(altCtrl,  Keys.OemOpenBrackets, () => workspaces.MoveFocusedWindowToPreviousMonitor(),   "Move focused window to previous monitor");
        manager.Subscribe(altCtrl,  Keys.OemCloseBrackets, () => workspaces.MoveFocusedWindowToNextMonitor(),      "Move focused window to next monitor");

        manager.Subscribe(alt,      Keys.OemOpenBrackets, () => context.Workspaces.SwitchFocusToPreviousMonitor(), "Switch focus to previous monitor");
        manager.Subscribe(alt,      Keys.OemCloseBrackets, () => context.Workspaces.SwitchFocusToNextMonitor(),    "Switch focus to next monitor");

	    manager.Subscribe(alt,      Keys.C, () => context.Workspaces.FocusedWorkspace.CloseFocusedWindow(),        "Close focused window");
    	manager.Subscribe(alt,      Keys.OemSemicolon, () => context.Workspaces.FocusedWorkspace.ResetLayout(),    "Reset layout");

        //* Layout management bindings
        // Winkey + Shift + H/L keys (vim keys), Shrinks/Expands primary area for current layout
        manager.Subscribe(altCtrl,  Keys.H, () => workspaces.FocusedWorkspace.ShrinkPrimaryArea(),                 "Shrink primary area");
        manager.Subscribe(altCtrl,  Keys.L, () => workspaces.FocusedWorkspace.ExpandPrimaryArea(),                 "Expand primary area");
        // Winkey + Ctrl + H/L keys (vim keys), Decreases/Increases primary window count for current layout
        manager.Subscribe(altShift, Keys.H, () => workspaces.FocusedWorkspace.DecrementNumberOfPrimaryWindows(),   "Subtract primary windows");
        manager.Subscribe(altShift, Keys.L, () => workspaces.FocusedWorkspace.IncrementNumberOfPrimaryWindows(),   "Add primary windows");
        // Winkey + Shift + K/J keys (vim keys), Moves window to next/previous position
        manager.Subscribe(altCtrl,  Keys.J, () => workspaces.FocusedWorkspace.SwapFocusAndNextWindow(),            "Move window to next position");
        manager.Subscribe(altCtrl,  Keys.K, () => workspaces.FocusedWorkspace.SwapFocusAndPreviousWindow(),        "Move window to previous position");
        // Winkey + K/J keys (vim keys), Focuses next/previous window
        manager.Subscribe(alt,      Keys.J, () => workspaces.FocusedWorkspace.FocusNextWindow(),                   "Focus next window");
        manager.Subscribe(alt,      Keys.K, () => workspaces.FocusedWorkspace.FocusPreviousWindow(),               "Focus previous window");
        // Winkey + Ctrl + Add(+)/Subtract(-) Resize inner gap
        manager.Subscribe(altShift, Keys.Add, () => gapPlugin.IncrementInnerGap(),                                 "Increase inner gap");
        manager.Subscribe(altShift, Keys.Subtract, () => gapPlugin.DecrementInnerGap(),                            "Decrease inner gap");
        // Winkey + Shift + Add(+)/Subtract(-) Resize outer gap
        manager.Subscribe(altCtrl,  Keys.Add, () => gapPlugin.IncrementOuterGap(),                                 "Increase outer gap");
        manager.Subscribe(altCtrl,  Keys.Subtract, () => gapPlugin.DecrementOuterGap(),                            "Decrease outer gap");

        //* Other shortcuts
        manager.Subscribe(altCtrl,  Keys.P, () => actionMenu.ShowMenu(actionMenuBuilder),                          "Show workspacer menu");
        manager.Subscribe(altCtrl,  Keys.R, () => context.Restart(),                                               "Restart workspacer");
        manager.Subscribe(altCtrl,  Keys.W, () => context.Enabled = !context.Enabled,                              "Toggle workspacer on/off");
        manager.Subscribe(altCtrl,  Keys.I, () => context.ToggleConsoleWindow(),                                   "Toggle workspacer log console");
        manager.Subscribe(altCtrl,  Keys.M, () => context.Windows.ToggleFocusedWindowTiling(),                     "Toggle tiling for current window");

        // Winkey + Period Next layout
        manager.Subscribe(alt,      Keys.I, () => context.Workspaces.FocusedWorkspace.NextLayoutEngine(),          "Next layout");
        // Winkey + Period Prev layout
        manager.Subscribe(alt,      Keys.U, () => context.Workspaces.FocusedWorkspace.PreviousLayoutEngine(),      "Previous layout");

        // // all layouts are based on SetLayoutEngines defined order

        // // mod+T switches to tall mode
        // context.Keybinds.Unsubscribe(mod, Keys.T);
        // context.Keybinds.Subscribe(mod, Keys.T, () =>
        // {
        //     typeof(Workspace).GetField("_layoutIndex", BindingFlags.NonPublic | BindingFlags.Instance).SetValue(context.Workspaces.FocusedWorkspace, 0);
        //     context.Workspaces.FocusedWorkspace.DoLayout();
        // });

        // // mod+F switches to full mode
        // context.Keybinds.Unsubscribe(mod, Keys.F);
        // context.Keybinds.Subscribe(mod, Keys.F, () =>
        // {
        //     typeof(Workspace).GetField("_layoutIndex", BindingFlags.NonPublic | BindingFlags.Instance).SetValue(context.Workspaces.FocusedWorkspace, 1);
        //     context.Workspaces.FocusedWorkspace.DoLayout();
        // });

        // // mod+Y switches to dwindle mode
        // context.Keybinds.Unsubscribe(mod, Keys.Y);
        // context.Keybinds.Subscribe(mod, Keys.Y, () =>
        // {
        //     typeof(Workspace).GetField("_layoutIndex", BindingFlags.NonPublic | BindingFlags.Instance).SetValue(context.Workspaces.FocusedWorkspace, 2);
        //     context.Workspaces.FocusedWorkspace.DoLayout();
        // });

        // // mod+U switches to grid mode
        // context.Keybinds.Unsubscribe(mod, Keys.U);
        // context.Keybinds.Subscribe(mod, Keys.U, () =>
        // {
        //     typeof(Workspace).GetField("_layoutIndex", BindingFlags.NonPublic | BindingFlags.Instance).SetValue(context.Workspaces.FocusedWorkspace, 3);
        //     context.Workspaces.FocusedWorkspace.DoLayout();
        // });

		string browserCmd;
		browserCmd = "/C start chrome";
		string browsernCmd;
		browsernCmd = "/C start chrome -incognito";
		string settingsCmd;
		settingsCmd = "/C start ms-settings:";

		// Keyboard Shortcuts
		// var mod = KeyModifiers.Alt;
		manager.Subscribe(altCtrl, Keys.T, () => System.Diagnostics.Process.Start("wt.exe"), "open terminal");
		manager.Subscribe(altCtrl, Keys.F, () => System.Diagnostics.Process.Start("explorer.exe"), "open file explorer");
		manager.Subscribe(altCtrl, Keys.E, () => System.Diagnostics.Process.Start("msedge.exe"), "open edge");
		manager.Subscribe(altCtrl, Keys.C, () => System.Diagnostics.Process.Start("CMD.exe", browserCmd), "open chrome");
		manager.Subscribe(altCtrl, Keys.N, () => System.Diagnostics.Process.Start("CMD.exe", browsernCmd), "open chrome (incognito)");
		manager.Subscribe(altCtrl, Keys.S, () => System.Diagnostics.Process.Start("CMD.exe", settingsCmd), "open windows settings");


    };
    setKeybindings();
});