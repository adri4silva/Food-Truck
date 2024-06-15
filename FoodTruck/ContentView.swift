//
//  ContentView.swift
//  FoodTruck
//
//  Created by Adrián Silva on 15/6/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 16) {
                TruckHeader()
                
//                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
//                    orders
//                    weather
//                    donuts
//                    socialFeed
//                }
//                .containerShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
//                .fixedSize(horizontal: false, vertical: true)
//                .padding([.horizontal, .bottom], 16)
//                .frame(maxWidth: 1200)
            }
        }
    }
}

#Preview {
    ContentView()
}
