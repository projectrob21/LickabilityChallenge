//
//  Picture.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

// *** Code Review Initializer *** //

struct Picture {
    let albumID: Int
    let picID: Int
    let title: String
    let url: String
    let thumbnailURL: String
    
    init?(json: [String:Any]) {
        guard let albumID = json["albumID"] as? Int,
        let picID = json["id"] as? Int,
        let title = json["title"] as? String,
        let url = json["url"] as? String,
        let thumbnailURL = json["thumbnailURL"] as? String else {
            print("could not initialize Picture from json"); return nil
        }
        
        self.albumID = albumID
        self.picID = picID
        self.title = title
        self.url = url
        self.thumbnailURL = thumbnailURL
    }

}
