//
//  InterstitialAdManager.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/3/24.
//

import GoogleMobileAds
import Foundation

class InterstitialAdManager: NSObject, GADFullScreenContentDelegate {
    
    static let shared = InterstitialAdManager()
    
    private var interstitial: GADInterstitialAd?
    private var lastAdShownTime: Date?
    
    private override init() {
        super.init()
    }
    
    func loadAd() async {
        guard interstitial == nil else {
            print("[AdManager] Ad is already loaded.")
            return
        }
        
        do {
            let interstitialAd = try await GADInterstitialAd.load(
                withAdUnitID: AdConfig.interstitialAdUnitID,
                request: GADRequest()
            )
            
            self.interstitial = interstitialAd
            self.interstitial?.fullScreenContentDelegate = self
            
            print("[AdManager] Interstitial ad loaded successfully.")
        } catch {
            print("[AdManager] Failed to load interstitial ad: \(error.localizedDescription)")
            
            self.interstitial = nil
        }
    }
    
    func showAd(from viewController: UIViewController) -> Bool {
        guard let interstitial = interstitial else {
            print("[AdManager] Ad not ready.")
            return false
        }
        
        if AppOpenAdManager.shared.isRecentlyShown() {
            print("[AdManager] App Open Ad was recently shown. Skipping Interstitial Ad.")
            return false
        }
        
        let now = Date()
        
        if let lastAdTime = lastAdShownTime, now.timeIntervalSince(lastAdTime) < AdConfig.minimumAdInterval {
            print("[AdManager] Ad shown too recently. Skipping.")
            return false
        }
        
        interstitial.present(fromRootViewController: viewController)
        lastAdShownTime = now
        print("[AdManager] Ad displayed successfully.")
        
        self.interstitial = nil
        
        return true
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("[AdManager] Ad will present.")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("[AdManager] Ad dismissed.")
        
        Task {
            await loadAd()
        }
    }
    
    func adDidFailToPresentFullScreenContent(_ ad: GADFullScreenPresentingAd, withError error: Error) {
        print("[AdManager] Ad failed to present: \(error.localizedDescription)")
        
        Task {
            await loadAd()
        }
    }
}
