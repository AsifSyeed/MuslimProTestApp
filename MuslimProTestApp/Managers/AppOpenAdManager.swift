//
//  AppOpenAdManager.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/3/24.
//

import GoogleMobileAds
import UIKit

class AppOpenAdManager: NSObject, GADFullScreenContentDelegate {
    
    static let shared = AppOpenAdManager()
    
    private var appOpenAd: GADAppOpenAd?
    private var isLoadingAd = false
    private var lastLoadedTime: Date?
    private var lastShownTime: Date?
    
    public func loadAd() async {
        guard !isLoadingAd, !isAdAvailable else {
            print("[AppOpenAdManager] Ad is already loaded or currently being loaded.")
            return
        }
        
        isLoadingAd = true
        
        do {
            let ad = try await GADAppOpenAd.load(
                withAdUnitID: AdConfig.appOpenAdUnitID,
                request: GADRequest()
            )
            
            appOpenAd = ad
            lastLoadedTime = Date()
            
            appOpenAd?.fullScreenContentDelegate = self
            
            print("[AppOpenAdManager] App Open Ad loaded successfully.")
        } catch {
            print("[AppOpenAdManager] Failed to load App Open Ad with error: \(error.localizedDescription)")
        }
        
        isLoadingAd = false
    }
    
    func showAdIfAvailable(from viewController: UIViewController) {
        guard isAdAvailable, !isLoadingAd else {
            print("[AppOpenAdManager] Ad not ready or currently being loaded.")
            return
        }
        
        appOpenAd?.present(fromRootViewController: viewController)
        
        lastShownTime = Date()
    }
    
    private var isAdAvailable: Bool {
        if let lastLoadedTime = lastLoadedTime, appOpenAd != nil {
            let isExpired = Date().timeIntervalSince(lastLoadedTime) > AdConfig.adExpirationTime
            return !isExpired
        }
        
        return false
    }

    
    func isRecentlyShown() -> Bool {
        guard let lastShownTime = lastShownTime else { return false }
        
        let timeSinceLastAd = Date().timeIntervalSince(lastShownTime)
        
        return timeSinceLastAd < AdConfig.minimumAdInterval
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("[AppOpenAdManager] Ad dismissed.")
        
        appOpenAd = nil
        
        Task {
            await loadAd()
        }
    }
    
    func adDidFailToPresentFullScreenContent(_ ad: GADFullScreenPresentingAd, withError error: Error) {
        print("[AppOpenAdManager] Failed to present App Open Ad with error: \(error.localizedDescription)")
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("[AppOpenAdManager] App Open Ad will present.")
    }
}
