//
//  ProfileItemModel.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/3/24.
//

import Foundation

struct ProfileItemModel {
    let title: String
    let iconName: String? // Optional icon
    let action: (() -> Void)? // Optional action for each row
}
