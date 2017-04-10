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

extension Picture: Equatable {
    static func == (lhs:Picture, rhs: Picture) -> Bool {
        return lhs.picID == rhs.picID &&
            lhs.albumID == rhs.albumID &&
            lhs.title == rhs.title &&
            lhs.imageURL == rhs.imageURL &&
            lhs.thumbnailURL == rhs.thumbnailURL
    }
}

// MARK: This extension has been replaced by SDWebImage framework
extension UIImageView {
    
    func download(from link: String?, contentMode: UIViewContentMode)
    {
        if let link = link {
            
            if let thumbnailURL = URL(string: link) {
                DispatchQueue.main.async {
                    
                    do {
                        let urlData = try Data(contentsOf: thumbnailURL)
                        self.image = UIImage(data: urlData)
                        self.layoutSubviews()
                        
                    } catch {
                        print("error: initializing image")
                        self.image = #imageLiteral(resourceName: "noImagePic")
                        self.layoutSubviews()
                        // *** Alert via a closure if connection is poor
                    }
                }
            }
        }
    }
}


