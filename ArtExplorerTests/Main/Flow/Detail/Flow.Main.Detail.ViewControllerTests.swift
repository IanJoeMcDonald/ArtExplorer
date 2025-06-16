//
//  Flow.Main.Detail.ViewControllerTests.swift
//  ArtExplorerTests
//
//  Created by Ian McDonald on 13/06/25.
//

import XCTest
@testable import ArtExplorer

final class FlowMainDetailViewControllerTests: XCTestCase {

    // MARK: Properties
    var sut: Flow.Main.Detail.ViewController!
    var viewModel: Flow.Main.Detail.ViewModel.Spy!

    // MARK: Setup & Tear Down
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = makeSUT()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        viewModel = nil
    }

    // MARK: Make SUT
    func makeSUT() -> Flow.Main.Detail.ViewController {
        viewModel = Flow.Main.Detail.ViewModel.Spy(objectId: 1)
        return Flow.Main.Detail.ViewController(viewModel: viewModel)
    }

    // MARK: View Did Load
    func testViewDidLoad() {
        XCTAssertEqual(viewModel.methodSpy.fetchInformationCalledCount, 1)
    }

    // MARK: States
    func testIsLoadingTrueState() {
        let expectation = self.expectation(description: "Awaiting state change")
        viewModel.state = .isLoading(true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotNil(self.sut.view.viewWithTag(-101010))
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testIsLoadingFalseState() {
        let expectation = self.expectation(description: "Awaiting state change")
        viewModel.state = .isLoading(false)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNil(self.sut.view.viewWithTag(-101010))
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testIsFavoriteTrueState() {
        let expectation = self.expectation(description: "Awaiting state change")
        viewModel.state = .isFavorite(true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.sut.navigationItem.rightBarButtonItem?.image, Model.Core.SystemImage.favoriteFill.image)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testIsFavoriteFalseState() {
        let expectation = self.expectation(description: "Awaiting state change")
        viewModel.state = .isFavorite(false)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.sut.navigationItem.rightBarButtonItem?.image, Model.Core.SystemImage.favorite.image)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testSetupState() {
        let expectation = self.expectation(description: "Awaiting state change")
        viewModel.state = .setup(with: Model.Main.Helper.createObject())

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.sut.testableView.testableTitleLabel.text, "Sunflowers")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    // MARK: Buttons
    func testFavoriteButtonTapped() {
        let expectation = self.expectation(description: "Awaiting state change")
        viewModel.state = .isFavorite(false)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let button = self.sut.navigationItem.rightBarButtonItem
            XCTAssertNotNil(button)
            _ = button?.target?.perform(button?.action, with: nil)

            XCTAssertEqual(self.viewModel.methodSpy.toggleFavoriteStatusCalledCount, 1)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testBackButtonTapped() {
        let button = sut.navigationItem.leftBarButtonItem
        _ = button?.target?.perform(button?.action, with: nil)
        XCTAssertEqual(viewModel.methodSpy.backButtonPressedCalledCount, 1)
    }
}
