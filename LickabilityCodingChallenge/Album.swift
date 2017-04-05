//
//  Album.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

struct Album {
    let albumID: Int
    var pictures = [Picture]()
}

extension Album: Equatable {
    static func == (lhs:Album, rhs: Album) -> Bool {
        return lhs.albumID == rhs.albumID &&
        lhs.pictures == rhs.pictures
    }
}
