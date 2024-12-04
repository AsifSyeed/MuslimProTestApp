//
//  MainTabBarController.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/2/24.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeInstallTime()
        
        setupViewControllers()
        
        loadInterstitialAd()
        
        delegate = self
    }
    
    private func loadInterstitialAd() {
        Task {
            await InterstitialAdManager.shared.loadAd()
        }
    }
    
    private func initializeInstallTime() {
        if !UserPreference.shared.exists(forKey: .installTimeKey) {
            let now = Date()
            UserPreference.shared.set(now, forKey: .installTimeKey)
            print("Install time recorded: \(now)")
        } else {
            let installTime = UserPreference.shared.get(forKey: .installTimeKey, as: Date.self)
            print("Install time already exists: \(installTime ?? Date())")
        }
    }
    
    private func setupViewControllers() {
        let homeViewController = HomeViewController()
        let settingsViewController = SettingsViewController()
        let profileViewController = ProfileViewController()
        let aboutViewController = AboutViewController()
        
        homeViewController.title = "Home"
        settingsViewController.title = "Settings"
        profileViewController.title = "Profile"
        aboutViewController.title = "About"
        
        self.viewControllers = [
            createNavController(for: homeViewController, title: "Home", image: UIImage(systemName: "house")),
            createNavController(for: settingsViewController, title: "Settings", image: UIImage(systemName: "gear")),
            createNavController(for: profileViewController, title: "Profile", image: UIImage(systemName: "person")),
            createNavController(for: aboutViewController, title: "About", image: UIImage(systemName: "info.circle"))
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if InterstitialAdManager.shared.showAd(from: self) {
            print("[MainTabBarController] Interstitial ad displayed.")
        } else {
            print("[MainTabBarController] Interstitial ad not shown.")
        }
    }
}
