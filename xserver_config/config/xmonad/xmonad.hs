import Graphics.X11.ExtraTypes.XF86
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Fullscreen
import XMonad.Layout.Spacing
import XMonad.Util.ClickableWorkspaces
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

import Control.Monad
import Data.Monoid
import System.Exit

import qualified XMonad.Util.Hacks as Hacks
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Workspaces
myNamedWorkspaces = ["\xf120", "\xf0626", "\xf059f", "\xf075a", "\xf11b"]
namedWorkSpacesKeys = [xK_F1..xK_F5]
myNumberedWorkspaces = map show [1..9]
numberedWorkspacesKeys = [xK_1..xK_9]
myWorkspaces = myNamedWorkspaces ++ myNumberedWorkspaces
myClickableWorkspaces = map xmobarAction myWorkspaces

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#333333"
myFocusedBorderColor = "#007184"

-- pretty print xmobar
-- ppXmobar = dynamicLog

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    -- , ((modm,               xK_d     ), spawn "dmenu_run")
    , ((modm,               xK_d     ), spawn "rofi -show drun")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_q     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_Down     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_Up     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_Down     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_Up     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_Left     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_Right     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_c     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_c     ), spawn "killall xmobar; xmobar; xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))

    -- Flameshot (it's mine, duh)
    , ((modm .|. shiftMask, xK_s), spawn "flameshot gui --clipboard")

    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) $ namedWorkSpacesKeys ++ numberedWorkspacesKeys
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

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

-- smartBorderEnable = True

-- allSpaces = spacingRaw True (Border edgeSize edgeSize edgeSize edgeSize) True (Border edgeSize edgeSize edgeSize edgeSize) False
edgeSize :: Int
edgeSize = 5

myLayout = avoidStruts $ fullscreenFull $ smartSpacingWithEdge edgeSize $ (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- Window rules:
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "whatsdesk"      --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "atlauncher"     --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]


-- Startup hook
myStartupHook = do
  spawnOnce "nitrogen --restore &"
  spawnOnce "dunst &"
  spawnOnce "picom &"
  spawnOnce "trayer --edge top --align right --SetDockType true \
          \--SetPartialStrut true --expand true --width 3 \
          \--transparent true --tint 0x101010 --height 18"

-- moreKeys
moreKeys = [
      ( (0, xF86XK_AudioRaiseVolume)  , spawn "pactl set-sink-volume @DEFAULT_SINK@ +2%")
    , ( (0, xF86XK_AudioLowerVolume)  , spawn "pactl set-sink-volume @DEFAULT_SINK@ -2%"      )
    , ( (0, xF86XK_AudioMute)         , spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"     ) 
    , ( (0, xF86XK_MonBrightnessUp)   , spawn "brightnessctl set 5%+")
    , ( (0, xF86XK_MonBrightnessDown) , spawn "brightnessctl set 5%-") ]

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
myXmobarPP = def {
  -- workspace highlighting
  -- ppCurrent = xmobarColor "#ffffff" "#df00df" . wrap " " " " ,
  ppCurrent = xmobarBorder "Full" "#ff00ff" 2 . xmobarColor "#ffffff" "" . wrap " " " ",
  ppVisible = xmobarBorder "Full" "#008800" 1 . xmobarColor "#008080" "",
  ppHidden =  xmobarBorder "Full" "#2F4F4F" 1 . xmobarColor "#2F4F4F" "" . wrap " " " ",
  ppUrgent =  xmobarColor "#FF0000" "" . wrap "*" "",
  -- other stuff
  ppTitleSanitize   = xmobarStrip ,
  ppTitle =   \t -> xmobarColor "#00dede" "" $ shorten 45 t ,
  ppSep =     "<fc=#666666>    </fc>" ,
  ppOrder =   \(ws:l:t:ex) -> [ws,t] -- ,
}

mySB = statusBarProp "xmobar ~/.config/xmobar/xmobarrc" $ clickablePP myXmobarPP
main = do
  xmonad
  . ewmhFullscreen
  . ewmh
  . withEasySB mySB toggleStrutsKey
  $ def {
      -- simple stuff
        terminal           = "alacritty",
        focusFollowsMouse  = True,
        clickJustFocuses   = True,
        borderWidth        = 1,
        modMask            = mod4Mask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        handleEventHook = handleEventHook def
                 <> Hacks.trayerPaddingXmobarEventHook,
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        startupHook        = myStartupHook
    } `additionalKeys` moreKeys
    where 
      toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
      toggleStrutsKey XConfig{ modMask = m } = (m, xK_b)

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
