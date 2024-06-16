//
//  FoodTruckApp.swift
//  FoodTruck
//
//  Created by Adrián Silva on 15/6/24.
//

import SwiftUI
import FirebaseCore

@main
struct FoodTruckApp: App {
    init() {
        // Initialises and configures Firebase when the app starts
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
