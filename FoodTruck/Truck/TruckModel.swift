//
//  TruckHeaderModel.swift
//  FoodTruck
//
//  Created by Adrián Silva on 15/6/24.
//

import SwiftUI

@Observable
final class FoodTruckModel {
    var donuts: [Int: Donut]
    var favouriteDonuts: [Int: Donut] = [:]
    var searchText: String = ""
    var isPremiumUser = false
    var isSettingsPresented = false
    
    var filteredDonuts: [Donut] {
        Array(
            donuts
                .filter { $0.value.matches(searchText: searchText) }
                .values
        )
        .sorted(by: { $0.id < $1.id })
    }
    
    var appVersionNumber: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "canary_wolf"
    }
    
    init(donuts: [Donut] = Donut.all) {
        self.donuts = Dictionary(uniqueKeysWithValues: donuts.map { ($0.id, $0) })
    }
    
    func isFavourite(donut: Donut) -> Bool {
        if let _ = favouriteDonuts[donut.id] {
            return true
        }
        return false
    }
    
    func toggleFavourite(donut: Donut) {
        if let _ = favouriteDonuts[donut.id] {
            favouriteDonuts.removeValue(forKey: donut.id)
            return
        }
        favouriteDonuts[donut.id] = donut
    }
}
