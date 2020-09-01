//
//  ListViewContentTests.swift
//  eLiteUITests
//
//  Created by Mayur Susare on 01/09/20.
//  Copyright © 2020 Local. All rights reserved.
//

import XCTest
@testable import eLite
class ListViewContentTests: XCTestCase {

    var listViewController : ListViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let rootNC = UINavigationController(rootViewController: ListViewController())
        rootNC.loadViewIfNeeded()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testControllerHasTableView() {
        XCTAssertNotNil(listViewController.tableViewList, "Controller should have a tableview")
    }
    
    func testControllerHasViewModel() {
        XCTAssertNotNil(listViewController.arrListContent, "Controller should have a list")
    }
    
    func testTableViewHasCells() {
        let cell = listViewController.tableViewList.dequeueReusableCell(withIdentifier: IBIdentifiers.CONTENT_CELL)
        XCTAssertNotNil(cell,"TableView should be able to dequeue cell with identifier: 'Cell'")
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(listViewController.tableViewList.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(listViewController.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(listViewController.tableViewList.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(listViewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(listViewController.responds(to: #selector(listViewController.numberOfSections(in:))))
        XCTAssertTrue(listViewController.responds(to: #selector(listViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(listViewController.responds(to: #selector(listViewController.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewCellHasReuseIdentifier() {
        let cell = listViewController.tableView(listViewController.tableViewList, cellForRowAt: IndexPath(row: 0, section: 0)) as? ContentViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "Content Cell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

}
