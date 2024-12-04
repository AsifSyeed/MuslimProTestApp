//
//  SettingsViewModel.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/3/24.
//

import Foundation

class SettingsViewModel {
    private(set) var settings: [SettingsItemModel] = []
    
    func fetchSettings() {
        settings = [
            SettingsItemModel(title: "Enable Notifications", hasSwitch: true, isOn: true),
            SettingsItemModel(title: "Dark Mode", hasSwitch: true, isOn: false),
            SettingsItemModel(title: "Account Settings", hasSwitch: false),
            SettingsItemModel(title: "Privacy Policy", hasSwitch: false)
        ]
    }
}
