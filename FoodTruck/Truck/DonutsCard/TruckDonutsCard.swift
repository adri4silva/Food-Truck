/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The donuts card showing in the Truck view.
*/

import SwiftUI

struct TruckDonutsCard: View {
    var donuts: [Donut]
    var groupText: String
    
    var body: some View {
        VStack {
            GroupBox(
                label: Label {
                    Text(groupText)
                } icon: {
                    Image.donutSymbol
                }
                .foregroundStyle(Color.accentColor)
            ) {
                DonutLatticeLayout {
                    ForEach(donuts.prefix(14)) { donut in
                        DonutView(donut: donut)
                    }
                }
                .frame(minHeight: 60, maxHeight: .infinity)
            }
        }
        .padding(10)
        .background()
    }
}

#Preview {
    return TruckDonutsCard(donuts: Donut.all, groupText: "Donuts")
}
