//
//  Picture.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

// *** Code Review Initializer *** //

struct Picture {
    let albumID: Int
    let picID: Int
    let title: String
    let imageURL: String
    var thumbnailURL: String
    
    init?(json: [String:Any]) {
        guard let albumID = json["albumId"] as? Int else { print("error: albumID"); return nil }
        guard let picID = json["id"] as? Int else { print("error: picID"); return nil }
        guard let title = json["title"] as? String else { print("error: title"); return nil }
        guard let imageURL = json["url"] as? String else { print("error: url"); return nil }
        guard let thumbnailURL = json["thumbnailUrl"] as? String else { print("error: thumbnailUrl"); return nil }
        
        self.albumID = albumID
        self.picID = picID
        self.title = title
        self.imageURL = imageURL
        self.thumbnailURL = thumbnailURL
    }
    
}

// MARK: *** https://developer.apple.com/swift/blog/?id=37 for Error handling
extension Picture {
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(errorHandlingWith jsonDictionary: [String:Any]) throws {
        // Extract albumID
        guard let albumID = jsonDictionary["albumID"] as? Int else {
            throw SerializationError.missing("albumID")
        }
        
        // Extract picID
        guard let picID = jsonDictionary["id"] as? Int else {
            throw SerializationError.missing("id")
        }
        
        // Extract title
        guard let title = jsonDictionary["title"] as? String else {
            throw SerializationError.missing("title")
        }
        
        // Extract url string
        guard let url = jsonDictionary["url"] as? String else {
            throw SerializationError.missing("url")
        }
        
        // Create url
        guard let thumbnailURL = jsonDictionary["thumbnailUrl"] as? String else {
            throw SerializationError.missing("thumbUrl")
        }
        
        // Initialize remaining properties
        self.albumID = albumID
        self.picID = picID
        self.title = title
        self.imageURL = url
        self.thumbnailURL = thumbnailURL
        
    }
}

// MARK: Able to compare and equate Photos
extension Picture: Equatable {
    static func == (lhs:Picture, rhs: Picture) -> Bool {
        return lhs.picID == rhs.picID &&
            lhs.albumID == rhs.albumID &&
            lhs.title == rhs.title &&
            lhs.imageURL == rhs.imageURL &&
            lhs.thumbnailURL == rhs.thumbnailURL
    }
}


