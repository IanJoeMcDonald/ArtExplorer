//
//  Flow.Main.Detail.ViewModelTests.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 13/06/25.
//

import Combine
import XCTest
@testable import ArtExplorer

final class FlowMainDetailViewModelTests: XCTestCase {

    // MARK: Properties
    var sut: Flow.Main.Detail.ViewModel!
    var cancellable: AnyCancellable?
    var coordinator: Coordinator.Main.Spy!
    var worker: Worker.Main.Mock!
    var persistenceWorker: Worker.Main.Persistence.Mock!

    // MARK: Setup & Tear Down
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        cancellable = nil
        coordinator = nil
        worker = nil
        persistenceWorker = nil
    }

    // MARK: Make SUT
    func makeSUT(objectId: Int = 1, favorite: Model.Main.Object? = nil) -> Flow.Main.Detail.ViewModel {
        coordinator = Coordinator.Main.Spy()
        worker = Worker.Main.Mock()
        persistenceWorker = Worker.Main.Persistence.Mock(favorite: favorite)

        return Flow.Main.Detail.ViewModel(
            objectId: objectId,
            coordinator: coordinator,
            worker: worker,
            persistenceWorker: persistenceWorker
        )
    }

    // MARK: Fetch Information
    func testFetchInformationNotFavorite() {
        var stateArray = [Flow.Main.Detail.State]()
        sut = makeSUT()
        cancellable = sut.statePublisher.sink { stateArray.append($0) }

        let expectation = self.expectation(description: "Awaiting worker return")
        sut.fetchInformation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(stateArray.count, 5)
            XCTAssertEqual(stateArray[0], .initial)
            XCTAssertEqual(stateArray[1], .isLoading(true))
            XCTAssertEqual(stateArray[2], .setup(with: Model.Main.Helper.createObject()))
            XCTAssertEqual(stateArray[3], .isFavorite(false))
            XCTAssertEqual(stateArray[4], .isLoading(false))
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchInformationError() {
        var stateArray = [Flow.Main.Detail.State]()
        sut = makeSUT()
        cancellable = sut.statePublisher.sink { stateArray.append($0) }
        worker.error = PersistenceError.valueNotFound

        let expectation = self.expectation(description: "Awaiting worker return")
        sut.fetchInformation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(stateArray.count, 3)
            XCTAssertEqual(stateArray[0], .initial)
            XCTAssertEqual(stateArray[1], .isLoading(true))
            XCTAssertEqual(stateArray[2], .isLoading(false))
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchInformationFavorite() {
        var stateArray = [Flow.Main.Detail.State]()
        sut = makeSUT(favorite: Model.Main.Helper.createObject())
        cancellable = sut.statePublisher.sink { stateArray.append($0) }

        let expectation = self.expectation(description: "Awaiting worker return")
        sut.fetchInformation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(stateArray.count, 5)
            XCTAssertEqual(stateArray[0], .initial)
            XCTAssertEqual(stateArray[1], .isLoading(true))
            XCTAssertEqual(stateArray[2], .setup(with: Model.Main.Helper.createObject()))
            XCTAssertEqual(stateArray[3], .isFavorite(true))
            XCTAssertEqual(stateArray[4], .isLoading(false))
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    // MARK: Toggle Favorite Status
    func testToggleFavoriteStatusWhenFavoriteSetsStatusFalse() {
        var stateArray = [Flow.Main.Detail.State]()
        sut = makeSUT(favorite: Model.Main.Helper.createObject())
        sut.fetchInformation()

        cancellable = sut.statePublisher.sink { stateArray.append($0) }

        let expectation = self.expectation(description: "Awaiting worker return")


        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            stateArray = []
            self.sut.toggleFavoriteStatus()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                XCTAssertEqual(stateArray.count, 1)
                XCTAssertEqual(stateArray[0], .isFavorite(false))
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 2)
    }

    func testToggleFavoriteStatusWhenNotFavoriteSetsStatusTrue() {
        var stateArray = [Flow.Main.Detail.State]()
        sut = makeSUT()
        sut.fetchInformation()

        cancellable = sut.statePublisher.sink { stateArray.append($0) }

        let expectation = self.expectation(description: "Awaiting worker return")


        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            stateArray = []
            self.sut.toggleFavoriteStatus()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                XCTAssertEqual(stateArray.count, 1)
                XCTAssertEqual(stateArray[0], .isFavorite(true))
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 2)
    }

    // MARK: Back Button Pressed
    func testBackButtonPressed() {
        sut = makeSUT()
        sut.backButtonPressed()
        XCTAssertEqual(coordinator.lastTriggeredRoute, .pop)
    }
}
