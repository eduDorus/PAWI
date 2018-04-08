//
//  TripleTests.swift
//  virtuelle-kugelbahnTests
//
//  Created by Lucas Schnüriger on 08.04.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import XCTest
@testable import virtuelle_kugelbahn

class TripleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNullValues() {
        XCTAssertNoThrow(Triple(0,0,0))
    }
    
    func testMaxValues() {
        XCTAssertNoThrow(Triple(Int.max,Int.max,Int.max))
    }

    func testMinValues() {
        XCTAssertNoThrow(Triple(Int.min,Int.min,Int.min))
    }
    
    func testEquality() {
        XCTAssertEqual(Triple(1,2,3), Triple(1,2,3))
    }

    func testComparability() {
        XCTAssertTrue(Triple(1,2,3) == Triple(1,2,3))
    }
    
    func testEqualityZero() {
        XCTAssertEqual(Triple(0,0,0), Triple(0,0,0))
    }
    
    func testUnequality() {
        XCTAssertNotEqual(Triple(0,0,0), Triple(1,0,0))
    }
    
    func testUnequalityOnDifferentOrder() {
        XCTAssertNotEqual(Triple(0,1,0), Triple(1,0,0))
    }
    
    func testHashvaluesEquality() {
        XCTAssertEqual(Triple(0,0,0).hashValue, Triple(0,0,0).hashValue)
    }
    
    func testHashvaluesUnequality() {
        XCTAssertNotEqual(Triple(0,0,0).hashValue, Triple(0,1,0).hashValue)
    }
    
    func testHashvaluesUnequalityOnDifferentOrder() {
        XCTAssertNotEqual(Triple(0,1,0).hashValue, Triple(1,0,0).hashValue)
    }
    

}
