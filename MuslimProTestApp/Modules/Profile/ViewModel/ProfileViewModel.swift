//
//  ProfileViewModel.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/3/24.
//

import Foundation

class ProfileViewModel {
    private(set) var rows: [ProfileItemModel] = []
    
    func fetchProfile() {
        rows = [
            ProfileItemModel(title: "Edit Profile", iconName: "pencil", action: {
                print("Edit Profile tapped")
            }),
            
            ProfileItemModel(title: "Account Details", iconName: "person", action: {
                print("Navigate to Account Details")
            }),
    
            ProfileItemModel(title: "Emergency Contact", iconName: "phone", action: {
                print("Navigate to Emergency Contact")
            }),
            
            ProfileItemModel(title: "Terms & Conditions", iconName: "doc.text", action: {
                print("Navigate to Terms & Conditions")
            }),
            ProfileItemModel(title: "Privacy Policy", iconName: "lock", action: {
                print("Navigate to Privacy Policy")
            }),
            ProfileItemModel(title: "Refund & Cancellation", iconName: "dollarsign.circle", action: {
                print("Navigate to Refund & Cancellation")
            }),
            
            ProfileItemModel(title: "Logout", iconName: "arrow.right.circle", action: {
                print("Logout tapped")
            })
        ]
    }
}
