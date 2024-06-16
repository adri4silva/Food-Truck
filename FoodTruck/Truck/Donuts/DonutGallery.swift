/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The donut gallery view.
*/

import SwiftUI

struct DonutGallery: View {
    @Bindable var model: FoodTruckModel
    
    var body: some View {
        ZStack {
            grid
        }
        .background()
        .toolbarRole(.browser)
        .searchable(text: $model.searchText)
        .navigationTitle("Donuts")
    }
    
    var grid: some View {
        GeometryReader { geometryProxy in
            ScrollView {
                DonutGalleryGrid(
                    model: model, 
                    width: geometryProxy.size.width
                )
            }
            .analyticsScreen(name: "donut_gallery")
        }
    }
}

#Preview {
    @Bindable var model = FoodTruckModel()
    return DonutGallery(model: model)
}
