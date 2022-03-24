//
//  characterDetailTests.swift
//  characterDetailTests
//
//  Created by Anton Tropashko on 23.03.2022.
//

import XCTest
@testable import characterDetail

let fakeService = FakeCharacterWorker()

var router: MarvelousRouterSpy?

class characterDetailTests: XCTestCase {
    let index = 49
    var viewController: TableViewControllerSpy!
    var presenter: CharactersPresenterSpy!
    var interactor: CharactersInteractor!
    
    override func setUpWithError() throws {
        _ = fakeService.loadCharacters(uptoindex: index, completion: { result in
            switch result {
            case .success(let array):
                XCTAssert(array.count > self.index)
            default:
                break
            }
        })
        router = MarvelousRouterSpy()
        viewController = TableViewControllerSpy()
        presenter = CharactersPresenterSpy(viewContoller: viewController)
        guard let interactor = CharactersInteractor(presenter: presenter) else {
            XCTAssert(false, "interactor can;t be constructed")
            return
        }
        interactor.presenter = presenter
        interactor.worker = FakeCharacterWorker()
        self.interactor = interactor
    }

    override func tearDownWithError() throws {
        router = nil
        viewController = nil
        presenter = nil
        interactor = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFakeWorker() throws {
        XCTAssert(fakeService.accumulator.count > index)

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPresentCharacters()
    {
        expectOnMainThread()
        XCTAssertTrue(presenter.groomed, "Not started presenter.groom")
    }
    
    func testAapplySnapshotInvoked()
    {
        expectOnMainThread()
        XCTAssertTrue(viewController.applySnapshotInvoked, "Not applied snapshot")
    }
    
    func expectOnMainThread()
    {
        let expectation = XCTestExpectation(description: "Completed doWorkOnUI")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)

    }
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
