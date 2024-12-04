//
//  UserPreference.swift
//  MuslimProTestApp
//
//  Created by Asif Reddot on 12/2/24.
//

import Foundation

public enum UserPreferenceKey: String {
    case installTimeKey
}

public class UserPreference {
    public static let shared = UserPreference()
        private let userDefaults: UserDefaults
    
    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    public func set<T>(_ value: T, forKey key: UserPreferenceKey) where T: Codable {
        do {
            let data = try JSONEncoder().encode(value)
            userDefaults.set(data, forKey: key.rawValue)
        } catch {
            print("Failed to save - \(key): \(error)")
        }
    }
    
    public func get<T>(forKey key: UserPreferenceKey, as type: T.Type) -> T? where T: Codable {
        guard let data = userDefaults.data(forKey: key.rawValue) else { return nil }
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            print("Failed to decode - \(key): \(error)")
            return nil
        }
    }
    
    public func exists(forKey key: UserPreferenceKey) -> Bool {
        return userDefaults.object(forKey: key.rawValue) != nil
    }
}
