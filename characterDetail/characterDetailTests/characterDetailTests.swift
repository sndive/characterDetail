//
//  characterDetailTests.swift
//  characterDetailTests
//
//  Created by Anton Tropashko on 23.03.2022.
//

import XCTest
@testable import characterDetail

let fakeService = FakeCharacterWorker()

class characterDetailTests: XCTestCase {
    let index = 49

    override func setUpWithError() throws {
        _ = fakeService.loadCharacters(uptoindex: index, completion: { result in
            switch result {
            case .success(let array):
                XCTAssert(array.count > self.index)
            default:
                break
            }
        })
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        XCTAssert(fakeService.accumulator.count > index)

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
