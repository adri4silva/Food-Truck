//
//  TruckHeaderModel.swift
//  FoodTruck
//
//  Created by Adrián Silva on 15/6/24.
//

import SwiftUI
import FirebaseAnalytics
import FirebaseCrashlytics

@Observable
final class FoodTruckModel {
    var donuts: [Int: Donut]
    var favouriteDonuts: [Int: Donut] = [:]
    var searchText: String = ""
    var isPremiumUser = false {
        didSet {
            handlePremiumAnalytics()
        }
    }
    var isSettingsPresented = false
    let userID = "my_user_id"
    
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
        configureFirebase()
    }
    
    func isFavourite(donut: Donut) -> Bool {
        Crashlytics.crashlytics().log("checking_favourite")
//        let firstFavouriteDonut = favouriteDonuts.values.first!

        if let _ = favouriteDonuts[donut.id] {
            Crashlytics.crashlytics()
                .record(error: NSError.init(domain: "SomeDomain", code: 345))
            return true
        }
        Crashlytics.crashlytics().log("favourite_not_found")
        return false
    }
    
    func toggleFavourite(donut: Donut) {
        Analytics.logEvent(
            "donut_toggle_favourite", 
            parameters: [
                "donut_id": donut.id,
                "donut_name": donut.name,
                "is_favourite": (!isFavourite(donut: donut)).description
            ]
        )
        if isFavourite(donut: donut) {
            favouriteDonuts.removeValue(forKey: donut.id)
            Crashlytics.crashlytics().log("removed_favourite")
            return
        }
        favouriteDonuts[donut.id] = donut
        Crashlytics.crashlytics().log("added_favourite")
    }
    
    func settingsButtonTapped() {
        isSettingsPresented = true
        Analytics.logEvent(
            "settings_button_tapped", 
            parameters: [
                "favourite_donuts_count": favouriteDonuts.values.count,
                "donuts_count": donuts.values.count
            ]
        )
    }
    
    func donutsCardTapped() {
        Analytics.logEvent(
            "donut_card_tapped", 
            parameters: [
                "favourite_donuts_count": favouriteDonuts.values.count,
                "donuts_count": donuts.values.count
            ]
        )
    }
    
    func configureFirebase() {
        Analytics.setUserID(userID)
        Crashlytics.crashlytics().setUserID(userID)
    }
    
    func handlePremiumAnalytics() {
        Analytics.logEvent(
            "premium_toggle", 
            parameters: [
                "toggle_value": isPremiumUser.description,
            ]
        )
        Analytics.setUserProperty(isPremiumUser.description, forName: "is_premium")
    }
}
