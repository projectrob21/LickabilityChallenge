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
    let urlString: String
    var thumbnailURL: URL?
    var image: UIImage?
    
    init?(json: [String:Any]) {
        guard let albumID = json["albumId"] as? Int else { print("error: albumID"); return nil }
        
        guard let picID = json["id"] as? Int else { print("error: picID"); return nil }
        guard let title = json["title"] as? String else { print("error: title"); return nil }
        
        guard let url = json["url"] as? String else { print("error: url"); return nil }
        
        
        self.albumID = albumID
        self.picID = picID
        self.title = title
        self.urlString = url
        
        /*
        // *** Allows http in plist Allow Arbitrary Loads ***
        if let thumbnailURL = URL(string: url) {
            do {
                let urlData = try Data(contentsOf: thumbnailURL)
                self.image = UIImage(data: urlData)
            } catch {
                print("error: initializing image")
                self.image = nil
                // *** could assign customized image
            }
        }
        */
    }
    
}

// MARK: *** https://developer.apple.com/swift/blog/?id=37 for Error handling
extension Picture {
    
    enum SerializationError: Error {
        case missing(String)
        case invaled(String, Any)
    }
    
    init(altJSON: [String:Any]) throws {
        // Extract albumID
        guard let albumID = altJSON["albumID"] as? Int else {
            throw SerializationError.missing("albumID")
        }
        
        // Extract picID
        guard let picID = altJSON["id"] as? Int else {
            throw SerializationError.missing("id")
        }
        
        // Extract title
        guard let title = altJSON["title"] as? String else {
            throw SerializationError.missing("title")
        }
        
        // Extract url string
        guard let url = altJSON["url"] as? String else {
            throw SerializationError.missing("url")
        }
        
        // Create url
        guard let thumbnailURL = URL(string: url) else {
            throw SerializationError.invaled("thumbnailURL", url)
        }
        
        
        var urlData: Data
        do {
            urlData = try Data(contentsOf: thumbnailURL)
        } catch let error {
            // *** could assign customized image
            print("error: \(error.localizedDescription)")
            throw SerializationError.invaled("image", url)
        }
        
        guard let image = UIImage(data: urlData) else {
            throw SerializationError.invaled("image", url)
        }
        
        
        // Initialize remaining properties
        self.albumID = albumID
        self.picID = picID
        self.title = title
        self.urlString = url
        self.image = image
        
    }
}

// MARK
extension UIImageView {
    
    func download(from link: String?, contentMode: UIViewContentMode)
    {
        if let link = link {
            
            if let thumbnailURL = URL(string: link) {
                do {
                    let urlData = try Data(contentsOf: thumbnailURL)
                    DispatchQueue.main.async {
                        self.image = UIImage(data: urlData)
                    }
                } catch {
                    print("error: initializing image")
                    self.image = nil
                    // *** could assign customized image
                }
            }
            
            
        }
    }
    
}
