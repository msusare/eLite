//
//  ContenListAPITest.swift
//  eLiteTests
//
//  Created by Mayur Susare on 01/09/20.
//  Copyright © 2020 Local. All rights reserved.
//

import XCTest
@testable import eLite
class ContenListAPITest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testFetchDataFromServer() {
        let listView = ListViewController()
        listView.fetchData { (listContent) in
            XCTAssertNotNil(listContent)
        }
    }
}
