//
//  LickabilityCodingChallengeTests.swift
//  LickabilityCodingChallengeTests
//
//  Created by Robert Deans on 4/10/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import XCTest
@testable import LickabilityCodingChallenge

class PictureInitializationTests: XCTestCase {
    let jsonDictionary = ["albumId": 1,
                          "id": 1,
                          "title": "accusamus beatae ad facilis cum similique qui sunt",
                          "url": "http://placehold.it/600/92c952",
                          "thumbnailUrl": "http://placehold.it/150/92c952"] as [String : Any]
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPictureInit() {
        let newPic = Picture(json: jsonDictionary)
        
        XCTAssert(newPic != nil)
        XCTAssert(newPic!.albumID == 1)
        XCTAssert(newPic!.picID == 1)
        XCTAssert(newPic!.title == "accusamus beatae ad facilis cum similique qui sunt")
        XCTAssert(newPic!.imageURL == "http://placehold.it/600/92c952")
        XCTAssert(newPic!.thumbnailURL == "http://placehold.it/150/92c952")
    }
    
    func testPictureInitThrows() {
        var newPic: Picture
        do {
            
            newPic = try Picture(errorHandlingWith: jsonDictionary)
            
            XCTAssert(newPic.albumID == 1)
            XCTAssert(newPic.picID == 1)
            XCTAssert(newPic.title == "accusamus beatae ad facilis cum similique qui sunt")
            XCTAssert(newPic.imageURL == "http://placehold.it/600/92c952")
            XCTAssert(newPic.thumbnailURL == "http://placehold.it/150/92c952")
            
        } catch {
            
        }
    }
    
    
}
