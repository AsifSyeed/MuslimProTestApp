//
//  AppDelegate.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/2/24.
//

import UIKit
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainTabBarController = MainTabBarController()
        window?.rootViewController = mainTabBarController
        window?.makeKeyAndVisible()
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        preloadAppOpenAd()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        guard let rootViewController = window?.rootViewController else {
            return
        }
        AppOpenAdManager.shared.showAdIfAvailable(from: rootViewController)
    }
    
    private func preloadAppOpenAd() {
        Task {
            await AppOpenAdManager.shared.loadAd()
        }
    }
}
