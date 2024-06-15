/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The grid view used in the DonutGallery.
*/

import SwiftUI

struct DonutGalleryGrid: View {
    @Bindable var model: FoodTruckModel
    var width: Double
    private let thumbnailSize: Double = 100
    private let gridItems = [
        GridItem(
            .adaptive(minimum: 150), 
            spacing: 20, 
            alignment: .top
        )
    ]
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 20) {
            ForEach(model.filteredDonuts) { donut in
                ZStack {
                    VStack {
                        DonutView(donut: donut)
                            .frame(width: thumbnailSize, height: thumbnailSize)

                        VStack {
                            let flavor = donut.flavors.mostPotentFlavor
                            Text(donut.name)
                            HStack(spacing: 4) {
                                flavor.image
                                Text(flavor.name)
                            }
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        }
                        .multilineTextAlignment(.center)
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                model.toggleFavourite(donut: donut)
                            } label: {
                                Image(
                                    systemName: model.isFavourite(donut: donut)
                                        ? "heart.fill" 
                                        : "heart"
                                )
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    @State var model = FoodTruckModel()
    return GeometryReader { geometryProxy in
        ScrollView {
            DonutGalleryGrid(model: model, width: geometryProxy.size.width)
        }
    }
}
