//
//  NikeAssessmentTests.swift
//  NikeAssessmentTests
//
//  Created by Pendyala Revanth on 9/22/20.
//

import XCTest
@testable import NikeAssessment

class NikeAssessmentTests: XCTestCase {
    
    var viewModel = AlbumListViewModel()
    let timeout = 10.0
    var shouldReloadExpectation = XCTestExpectation(description: "shouldReload")
    var displayErrorExpectation = XCTestExpectation(description: "displayError")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSuccessResponse() {
        viewModel.service = MockAlbumFetchSuccess()
        viewModel.shouldReload = {
            self.shouldReloadExpectation.fulfill()
        }
        viewModel.fetchAlbums()
        wait(for: [shouldReloadExpectation], timeout: timeout)
        XCTAssertEqual(viewModel.numberOfRows, 38)
        XCTAssertNil(viewModel.dataForRow(at: 40))
        let album = viewModel.dataForRow(at: 0)
        XCTAssertNotNil(album)
        XCTAssertEqual(album?.id, "1528423147")
        XCTAssertEqual(album?.artistName, "Chris Stapleton")
        XCTAssertEqual(album?.name, "Starting Over")
        XCTAssertEqual(album?.artistId, "1752134")
        XCTAssertEqual(album?.artworkUrl100, "https://is3-ssl.mzstatic.com/image/thumb/Music114/v4/0e/e1/be/0ee1bebf-783b-787e-8f34-0d0df37b3f69/20UMGIM71875.rgb.jpg/200x200bb.png")
        XCTAssertEqual(album?.url, "https://music.apple.com/us/album/starting-over/1528423147?app=music")
        XCTAssertEqual(album?.releaseDate, "2020-11-13")
        XCTAssertEqual(album?.copyright, "A Mercury Nashville Release; ℗ 2020 Sound Records, under exclusive license to UMG Recordings, Inc.")
    }

    func testFailureResponse() {
        viewModel.service = MockAlbumFetchFailure()
        viewModel.displayError = {
            self.displayErrorExpectation.fulfill()
        }
        viewModel.fetchAlbums()
        wait(for: [displayErrorExpectation], timeout: timeout)
        XCTAssertEqual(viewModel.numberOfRows, 0)
        XCTAssertNil(viewModel.dataForRow(at: 0))
    }

    func testError() {
        viewModel.service = MockAlbumFetchSuccessWithInavlid()
        viewModel.displayError = {
            self.displayErrorExpectation.fulfill()
        }
        viewModel.fetchAlbums()
        wait(for: [displayErrorExpectation], timeout: timeout)
        XCTAssertEqual(viewModel.numberOfRows, 0)
        XCTAssertNil(viewModel.dataForRow(at: 0))
    }
}
