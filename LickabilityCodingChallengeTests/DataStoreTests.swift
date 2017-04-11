//
//  DataStoreTests.swift
//  
//
//  Created by Robert Deans on 4/10/17.
//
//

import XCTest
@testable import LickabilityCodingChallenge

class DataStoreTests: XCTestCase {
    var dataStore: DataStore!
    
    override func setUp() {
        super.setUp()
        dataStore = DataStore()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDoesStorePopulate() {

        dataStore.populatePicturesFromDictionary()

        XCTAssert(dataStore.pictures.count > 0)
        XCTAssert(dataStore.albums.count > 0)

    }
    
    func testJSONHasValidData() {
        var dictionaryCount: Int = 0
        
        JSONParser.getDictionary(from: "photos") { (returnDictionary) in
            dictionaryCount = returnDictionary.count
        }
        
        dataStore.populatePicturesFromDictionary()
        
        XCTAssert(dataStore.pictures.count == dictionaryCount)
        
    }
    
}
