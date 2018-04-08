//
//  TrackMapTests.swift
//  virtuelle-kugelbahnTests
//
//  Created by Lucas Schnüriger on 08.04.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import XCTest
@testable import virtuelle_kugelbahn

class TrackMapTests: XCTestCase {
    var map : TrackMap<BasicCube>!
    var location : Triple<Int,Int,Int>!
    var cube : BasicCube!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        map = TrackMap()
        location = Triple(0,0,0)
        cube = BasicCube()
        map.add(element: cube, atLocation: location)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        map = nil
        location = nil
        cube = nil
    }
    
    func testGetElement() {
        XCTAssertEqual(map.getElement(at: location), cube)
    }
    
    func testRemoveElement() {
        map.removeElement(at: location)
        XCTAssertNil(map.getElement(at: location))
    }
    
    func testGetKeys() {
        XCTAssertEqual(map.getKeys(forElement: cube).first, location)
    }
    
    func testGetElementsAtLevel() {
        let secondLocation = Triple(1,0,0)
        let secondCube = BasicCube()
        let testmap = [location : cube, secondLocation : secondCube]
        map.add(element: secondCube, atLocation: secondLocation)
        map.add(element: BasicCube(), atLocation: Triple(1,1,1))
        XCTAssertEqual(map.getElements(atLevel: 0), testmap)
    }

    func testGetElementsAtLevelIncorrect() {
        let secondLocation = Triple(1,0,0)
        let secondCube = BasicCube()
        let testmap = [location : cube, secondLocation : secondCube]
        map.add(element: secondCube, atLocation: secondLocation)
        map.add(element: BasicCube(), atLocation: Triple(1,0,1)) // this cube should get return but is not in the testmap
        XCTAssertNotEqual(map.getElements(atLevel: 0), testmap)
    }

}
