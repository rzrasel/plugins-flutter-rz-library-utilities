# DeviceUtils

A lightweight, static utility class for Flutter apps that provides convenient helpers for common device, screen, keyboard, orientation, and system UI operations.

## Features

- Keyboard hide / height / visibility
- Screen size, height, width, pixel ratio
- Status bar height, color, hide/show
- Orientation check (landscape / portrait)
- Fullscreen mode & preferred orientations
- Dark mode check
- Navigation helper
- Internet connection check
- Platform checks: `isIOS`, `isAndroid`, `isWeb`, `isPhysicalDevice`
- Haptic vibrate
- AppBar & BottomNavigationBar height

## Installation

Import:

```dart
import 'package:rz_library_utilities/rz_library_utilities.dart';
```

## Usages:

1. Keyboard

// Hide keyboard
```dart
DeviceUtils.hideKeyboard(context);
```

// Get keyboard height
```dart
double height = DeviceUtils.getKeyboardHeight(context);
```

// Check if keyboard visible
```dart
bool visible = await DeviceUtils.isKeyboardVisible(context);
```

2. Screen & Device

```dart
// Screen size
Size size = DeviceUtils.screenSize(context);
double h = DeviceUtils.screenHeight(context);
double w = DeviceUtils.screenWidth(context);

// Aliases
double h2 = DeviceUtils.getScreenHeight(context);
double w2 = DeviceUtils.getScreenWidth(context);

// Pixel ratio & status bar
double ratio = DeviceUtils.getPixelRatio(context);
double statusBar = DeviceUtils.getStatusBarHeight(context);

// AppBar & BottomNav
double appBarH = DeviceUtils.getAppBarHeight();
double bottomNavH = DeviceUtils.getBottomNavigationBarHeight();
```

3. Theme & Orientation

```dart
bool isDark = DeviceUtils.isDarkMode(context);

bool isLandscape = DeviceUtils.isLandscapeOrientation(context);
bool isPortrait = DeviceUtils.isPortraitOrientation(context);

await DeviceUtils.setPreferredOrientations([
  DeviceOrientation.portraitUp,
]);
```

4. Status Bar & Fullscreen

```dart
// Set status bar color
await DeviceUtils.setStatusBarColor(Colors.blue);

// Hide / Show
DeviceUtils.hideStatusBar();
DeviceUtils.showStatusBar();

// Fullscreen
DeviceUtils.setFullScreen(true); // immersive
DeviceUtils.setFullScreen(false); // edge to edge
```

5. Platform

```dart
if (DeviceUtils.isIOS()) { }
if (DeviceUtils.isAndroid()) { }
if (DeviceUtils.isWeb()) { }

// Physical device check
bool isPhysical = await DeviceUtils.isPhysicalDevice(context);
```

6. Navigation & UI

```dart
DeviceUtils.navigateToScreen(context, MyScreen());

DeviceUtils.vibrate(Duration(milliseconds: 500));
```
7. Internet

```dart
bool hasInternet = await DeviceUtils.hasInternetConnection();
if (!hasInternet) {
// show offline
}
```

## API Reference

| Method | Return | Description |
|---|---|---|
| `hideKeyboard(context)` | `void` | Hide keyboard |
| `screenSize(context)` | `Size` | Screen size |
| `screenHeight(context)` | `double` | Screen height |
| `screenWidth(context)` | `double` | Screen width |
| `getScreenHeight(context)` | `double` | Screen height alias |
| `getScreenWidth(context)` | `double` | Screen width alias |
| `getPixelRatio(context)` | `double` | Device pixel ratio |
| `getStatusBarHeight(context)` | `double` | Status bar height |
| `getBottomNavigationBarHeight()` | `double` | Bottom navigation bar height |
| `getAppBarHeight()` | `double` | AppBar height |
| `getKeyboardHeight(context)` | `double` | Keyboard height |
| `isKeyboardVisible(context)` | `Future<bool>` | Keyboard visibility |
| `isDarkMode(context)` | `bool` | Dark mode check |
| `isLandscapeOrientation(context)` | `bool` | Landscape check |
| `isPortraitOrientation(context)` | `bool` | Portrait check |
| `setFullScreen(bool)` | `void` | Fullscreen toggle |
| `setStatusBarColor(Color)` | `Future<void>` | Set status bar color |
| `hideStatusBar()` | `void` | Hide status bar |
| `showStatusBar()` | `void` | Show status bar |
| `setPreferredOrientations(List)` | `Future<void>` | Set device orientations |
| `hasInternetConnection()` | `Future<bool>` | Internet connectivity check |
| `isIOS()` | `bool` | iOS platform check |
| `isAndroid()` | `bool` | Android platform check |
| `isWeb()` | `bool` | Web platform check |
| `isPhysicalDevice(context)` | `Future<bool>` | Physical device check |
| `navigateToScreen(context, screen)` | `void` | Push a screen |
| `vibrate(Duration)` | `void` | Haptic vibration |