--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified XMonad.Actions.FlexibleResize as Flex

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.Maximize

import Data.List -- for `isSuffixOf
import XMonad.Layout.IM
import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.ResizableTile
import XMonad.Layout.Accordion
import XMonad.Hooks.EwmhDesktops

import XMonad.Hooks.ManageHelpers -- for full screen stuff
import Data.Ratio ((%))

import XMonad.Layout.NoBorders
import XMonad.Actions.GridSelect

import XMonad.Hooks.ManageDocks


gsconfig1 = defaultGSConfig { gs_cellheight = 64 , gs_cellwidth = 192 }

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
--myTerminal      = "urxvt"
myTerminal     = "Terminal"

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
myNumlockMask   = mod2Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
--myWorkspaces    = ["web","dev","3","4","5","6","7","8","9"]
myWorkspaces     = ["mail", "web:misc", "dev", "term1", "term2", "term3", "7", "chat", "warez"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#343434"
myFocusedBorderColor = "#ff6666"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- launch a terminal
    [ ((modMask,		xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    --, ((modMask,               xK_d     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ((modMask,               xK_d     ), spawn "exe=`dmenu_run -nb black -nf white -sb red -sf yellow -p 'Search: '` && eval \"exec $exe\"")

    -- launch xfce4-launcher
    , ((modMask,               xK_p     ), spawn "xfrun4")

    -- launch gmrun
    , ((modMask .|. shiftMask, xK_p     ), spawn "xfce4-appfinder")

    -- close focused window 
    , ((modMask .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modMask,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modMask,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modMask,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modMask,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modMask,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modMask .|. shiftMask, xK_m     ), windows W.focusMaster  )

    -- Maximize the focused window temporarily
    , ((modMask,               xK_m     ), withFocused $ sendMessage . maximizeRestore)

    -- Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modMask,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modMask,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- toggle the status bar gap
    -- TODO, update this binding with avoidStruts , ((modMask              , xK_b     ),

    -- Quit xmonad
    --, ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modMask .|. shiftMask, xK_q     ), spawn "xfce4-session-logout")

    -- Restart xmonad
    , ((modMask              , xK_q     ), restart "xmonad" True)
    
    -- to hide/unhide the panel
    , ((modMask              , xK_b), sendMessage ToggleStruts)

    , ((modMask              , xK_g), goToSelected gsconfig1 )
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    --, ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))
    , ((modMask, button3), (\w -> focus w >> Flex.mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = onWorkspace "7" gimpLayout $
 smartBorders $ avoidStruts $ 
 (
   withIM (1%10) (Role "buddy_list") $
   --withIM (1%3) (ClassName "Thunar") $
   (
    maximize (tiled) ||| tall ||| Mirror tall ||| Mirror tiled ||| Accordion 
    ||| Full ||| gimpLayout
   ))
    where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     tall    = ResizableTall 1 (3/100) (1/2) []
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
     -- Gimp
     gimpLayout  = withIM (1%10) 
                   (Role "gimp-toolbox") $ reflectHoriz $ withIM (1%10) 
                   (Role "gimp-dock") Full

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"                    --> doFloat
    --, className =? "Gimp"                       --> doFloat
    , className =? "Vlc"                        --> doFloat
    , className =? "Xfce4-appfinder"            --> doFloat
    , className =? "Xfrun4"                     --> doFloat
    , className =? "Keepassx"                   --> doFloat
    , className =? "Nm-connection-editor"       --> doFloat
    , className =? "Nm-openconnect-auth-dialog" --> doFloat
    , className =? "Shotwell"                   --> doFloat
    , className =? "Abrt"                       --> doFloat
    , className =? "Xfce4-screenshooter"        --> doFloat
    , className =? "Xfce4-notifyd"              --> doIgnore
    , icon      =? "File Operation Progress"    --> doFloat
    , resource  =? "desktop_window"             --> doIgnore
    , resource  =? "kdesktop"                   --> doIgnore 
    -- Position apps into workspaces
    , className =? "claws-mail"                 --> doShift "mail"
    , icon      =? "About Claws Mail"           --> doFloat
    , icon      =? "Preferences"                --> doFloat
    , role      =? "compose"                    --> doFloat
    , icon      =? "Address book"               --> doFloat
    , icon      =? "Edit Person Details"        --> doFloat
    , icon      =? "Discard message"            --> doFloat
    , className =? "google-chrome"              --> doShift "web:misc"
    , className =? "Pidgin"                     --> doShift "chat"
    , icon      =? "Buddy Information"          --> doFloat
    , icon      =? "XMPP Message Error"         --> doFloat
    , icon      =? "Thunderbird Preferences"    --> doFloat
    , icon      =? "New meeting"                --> doFloat
    , className =? "Orage"                      --> doFloat
    , className =? "xchat"                      --> doShift "chat"
    , className =? "deluge-gtk"                 --> doShift "warez"
    --, className =? "Eclipse"                    --> doShift "dev"
    , className =? "Gimp"                       --> doShift "7" 
    ] 
     <+> composeOne 
    [ isKDETrayWindow -?> doIgnore
    , transience
    , isFullscreen -?> doFullFloat
    , resource =? "stalonetray" -?> doIgnore
    ] 
     <+> manageDocks
 where 
  role = stringProperty "WM_WINDOW_ROLE"
  icon = stringProperty "WM_ICON_NAME"


-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True


------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--
-- myLogHook = return ()

--myLogHook :: X ()
--myLogHook = fadeInactiveLogHook fadeAmount
--     where fadeAmount = 0.8

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will 
-- use the defaults defined in xmonad/XMonad/Config.hs
-- 
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal
        , focusFollowsMouse  = myFocusFollowsMouse
        , borderWidth        = myBorderWidth
        , modMask            = myModMask
      --  , numlockMask        = myNumlockMask
        , workspaces         = myWorkspaces
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
      -- key bindings
        , keys               = myKeys
        , mouseBindings      = myMouseBindings
      -- hooks, layouts
        --, layoutHook         =  avoidStruts $ layoutHook defaultConfig
        , layoutHook         = myLayout
        , manageHook         = manageDocks <+> myManageHook
        --, logHook            = ewmhDesktopsLogHook <+> myLogHook
        , logHook            = ewmhDesktopsLogHook
        , startupHook        = myStartupHook
        , handleEventHook    = fullscreenEventHook        
    }
