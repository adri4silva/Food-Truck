@testable import FoodTruck
import Testing

struct TruckModel {
    var sut: FoodTruckModel!
    
    init() {
        sut = FoodTruckModel()
    }
    
    @Test
    func initialState() {
        #expect(Array(sut.donuts.values) == Donut.all)
    }
}
