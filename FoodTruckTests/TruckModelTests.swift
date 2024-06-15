import XCTest
@testable import FoodTruck

final class TruckModelTests: XCTestCase {
    private var sut: FoodTruckModel!
    
    override func setUp() {
        super.setUp()
        sut = FoodTruckModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_initialisation() {
        XCTAssert(sut.favouriteDonuts.values.isEmpty)
        XCTAssert(sut.searchText.isEmpty)
        XCTAssertFalse(sut.isPremiumUser)
        XCTAssertFalse(sut.isSettingsPresented)
    }
    
    func test_toggleFavourite_afterToggling_addsFavourite() {
        // Given
        let donut = Donut.classic
        
        // When
        sut.toggleFavourite(donut: donut)
        
        // Then
        XCTAssertEqual(sut.favouriteDonuts.values.first, donut)
    }
    
    func test_toggleFavourite_favouriteDonut_afterToggling_removesFavourite() {
        // Given
        let donut = Donut.classic
        sut.toggleFavourite(donut: donut)
        
        // When
        sut.toggleFavourite(donut: donut)
        
        // Then
        XCTAssert(sut.favouriteDonuts.values.isEmpty)
    }
    
    func test_search_whenSearching_returnsFoundDonut() {
        // Given
        let donut = Donut.classic
        
        // When
        sut.searchText = donut.name
        
        // Then
        XCTAssertEqual(sut.filteredDonuts, [donut])
    }
}
