//
//  Donut.swift
//  FoodTruck
//
//  Created by Adrián Silva on 15/6/24.
//

import SwiftUI

struct DonutView: View {
    enum Constants {
        static let donutThumbnailSize: Double = 128
    }
    var donut: Donut
    var visibleLayers: DonutLayer = .all

    init(donut: Donut, visibleLayers: DonutLayer = .all) {
        self.donut = donut
        self.visibleLayers = visibleLayers
    }
    
    var body: some View {
        GeometryReader { proxy in
            let useThumbnail = min(proxy.size.width, proxy.size.height) <= Constants.donutThumbnailSize

            ZStack {
                if visibleLayers.contains(.dough) {
                    donut.dough.image(thumbnail: useThumbnail)
                        .resizable()
                        .interpolation(.medium)
                        .scaledToFit()
                        .id(donut.dough.id)
                }

                if let glaze = donut.glaze, visibleLayers.contains(.glaze) {
                    glaze.image(thumbnail: useThumbnail)
                        .resizable()
                        .interpolation(.medium)
                        .scaledToFit()
                        .id(glaze.id)
                }

                if let topping = donut.topping, visibleLayers.contains(.topping) {
                    topping.image(thumbnail: useThumbnail)
                        .resizable()
                        .interpolation(.medium)
                        .scaledToFit()
                        .id(topping.id)
                }
            }
            .aspectRatio(1, contentMode: .fit)
            // Applies effects to the parent view before the child
            // Blur, shades...
            .compositingGroup()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    DonutView(donut: .preview, visibleLayers: .all)
}
