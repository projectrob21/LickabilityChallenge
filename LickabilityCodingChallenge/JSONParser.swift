//
//  JSONParser.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

final class JSONParser {
    
    
    static func getDictionary(from jsonFilename: String, completion: @escaping ([[String : Any]]) -> Void) {
        guard let filePath = Bundle.main.path(forResource: jsonFilename, ofType: "json") else { print("error unwrapping json file path"); return }
        
        do {
            let data = try NSData(contentsOfFile: filePath, options: NSData.ReadingOptions.uncached)
            
            guard let pictureDictionary = try JSONSerialization.jsonObject(with: data as Data, options: []) as? [[String : Any]] else { print("error typecasting json dictionary"); return }
            
            completion(pictureDictionary)
        } catch {
            print("error reading data from file in json serializer")
        }
    }
    
    static func populatePicturesFromDictionary() {
        // *** send pictures to data store ?
        let store = DataStore.shared
        
        getDictionary(from: "photos") { pictureDictionary in
            
            for pictureNode in pictureDictionary.map({ Picture(json: $0) }) {
                if let picture = pictureNode {
                    store.pictures.append(picture)

                    
                    
                    
                    let containsAlbum = store.albums.contains(where: { (album) in
                        if album.albumID == picture.albumID {
                            return true
                        } else {
                            return false
                        }
                    })
                 
                    print("containsAlbum = \(containsAlbum)")
                    
                    if containsAlbum == false {
                        let newAlbum = Album(albumID: picture.albumID, pictures: [picture])
                        store.albums.append(newAlbum)
                    } else {
                        for (index, album) in store.albums.enumerated() {
                            if album.albumID == picture.albumID {
                                store.albums[index].pictures.append(picture)
                                print("album \(store.albums[index].albumID) has \(store.albums[index].pictures.count) pictures")

                            }
                        }
                    }
                    
                    
                    
                    
                    
                }
            }
            
        }
    }
    
}
