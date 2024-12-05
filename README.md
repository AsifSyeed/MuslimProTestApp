# MuslimProTestApp

MuslimProTestApp is an iOS application designed to demonstrate key development skills, including modular architecture, ad integration, dynamic UI components, and seamless navigation. The app includes five key modules: Home, Comments, Profile, Settings, and About.

---

## Features

- **Home Module**: Displays a dynamic list of items. Each item navigates to a comments page for user interaction.
- **Comments Module**: Provides a dynamic comments section with adjustable text input and a responsive UI.
- **Profile Module**: Displays user information and configurable settings with a header view.
- **Settings Module**: Offers user-configurable options with toggles and detailed actions.
- **About Module**: Displays app details, version information, and legal links.
- **Ad Integration**: Includes App Open Ads and Interstitial Ads using Google AdMob.

---

## Requirements

- Xcode 15.0+
- iOS 17.0+
- Swift 5.0+
- Swift Package Manager for dependency management
- Google AdMob SDK

---

## Project Structure

```plaintext
MuslimProTestApp
├── Base
│   └── MainTabBarController.swift
├── Constants
│   └── AdConfig.swift
├── Managers
│   ├── AppOpenAdManager.swift
│   ├── InterstitialAdManager.swift
│   └── UserPreference.swift
├── Modules
│   ├── About
│   │   └── AboutViewController.swift
│   ├── Comments
│   │   ├── Model
│   │   │   └── CommentItemModel.swift
│   │   ├── View
│   │   │   ├── CommentTableViewCell.swift
│   │   │   └── CommentsViewController.swift
│   │   └── ViewModel
│   │       └── CommentsViewModel.swift
│   ├── Home
│   │   ├── Model
│   │   │   └── HomeItemModel.swift
│   │   ├── View
│   │   │   ├── HomeItemTableViewCell.swift
│   │   │   └── HomeViewController.swift
│   │   └── ViewModel
│   │       └── HomeViewModel.swift
│   ├── Profile
│   │   ├── Model
│   │   │   └── ProfileItemModel.swift
│   │   ├── View
│   │   │   ├── ProfileHeaderView.swift
│   │   │   ├── ProfileItemTableViewCell.swift
│   │   │   └── ProfileViewController.swift
│   │   └── ViewModel
│   │       └── ProfileViewModel.swift
│   └── Settings
│       ├── Model
│       │   └── SettingsItemModel.swift
│       ├── View
│       │   ├── SettingsItemTableViewCell.swift
│       │   └── SettingsViewController.swift
│       └── ViewModel
│           └── SettingsViewModel.swift
├── AppDelegate.swift
├── Info.plist
└── LaunchScreen.storyboard
```

---

## Ad Integration

### App Open Ads
- **Manager**: `AppOpenAdManager.swift`
- **Features**:
  - Automatically loads ads and keeps them ready for display.
  - Displays an ad when the app transitions from the background to the foreground.
  - Ensures that ads are not shown too frequently by checking expiration and usage intervals.
- **Configuration**: Uses test `appOpenAdUnitID` provided by Google AdMob.

### Interstitial Ads
- **Manager**: `InterstitialAdManager.swift`
- **Features**:
  - Loads and displays ads between user interactions, such as tab switches.
  - Includes timing logic to avoid showing ads too frequently.
  - Ensures that ads do not interrupt critical user flows.
- **Configuration**: Uses test `interstitialAdUnitID` provided by Google AdMob.
- **Logic**:
  - Interstitial ads are displayed only after a defined delay following the App Open Ad to avoid overwhelming the user.

### AdConfig
- Centralized configuration for ad unit IDs and timing settings.
- Includes all necessary constants for managing ad timing and behavior across the app.

---

## How to Run

To run the project on your local machine, follow these steps:

### Prerequisites
- Install the **latest Xcode version** (14.0 or later).
- Ensure your system meets the minimum requirements for iOS development.

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/AsifSyeed/MuslimProTestApp.git
   ```
2. Navigate to the project directory:
   ```bash
   cd MuslimProTestApp
   ```
3. Open the project in Xcode:
   ```bash
   open MuslimProTestApp.xcodeproj
   ```
4. Install dependencies using Swift Package Manager (if not already installed):
   - Xcode will automatically resolve dependencies when you open the project. If not:
     - Go to `File > Packages > Resolve Package Dependencies` in Xcode.
5. Select the target simulator or physical device.
6. Run the project:
   - Press the **Run** button in Xcode (`Cmd + R`).
   - Ensure the deployment target matches your selected device
  
## Acknowledgments

- [Google AdMob](https://admob.google.com/) - For providing test ad units and seamless ad integration.
- [Swift Package Manager](https://www.swift.org/package-manager/) - For dependency management and package integration.

