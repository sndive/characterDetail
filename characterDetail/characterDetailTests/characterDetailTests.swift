//
//  characterDetailTests.swift
//  characterDetailTests
//
//  Created by Anton Tropashko on 24.03.2022.
//

import XCTest

class characterDetailTests: XCTestCase {
    let index = 49
    var viewController: TableViewControllerSpy!
    var presenter: CharactersPresenter!
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
        presenter = CharactersPresenter(viewContoller: viewController)
        guard let interactor = CharactersInteractor(presenter: presenter) else {
            XCTAssert(false, "interactor can;t be constructed")
            return
        }
        interactor.presenter = presenter
        interactor.worker = FakeCharacterWorker()
        self.interactor = interactor
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDetailing() throws {
        expectOnMainThread()
        interactor.detailCharacter(atindex: 0)
        XCTAssert(router?.character != nil)
    }

    func expectOnMainThread()
    {
        let expectation = XCTestExpectation(description: "Completed doWorkOnUI")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

