//
//  DataStore.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

final class DataStore {
    
    static let shared = DataStore()
    
    var pictures = [Picture]()
    var albums = [Album]()
    
    func populatePicturesFromDictionary() {
                
        JSONParser.getDictionary(from: "photos") { pictureDictionary in
            
            for pictureNode in pictureDictionary {
                do {
                    let picture = try Picture(errorHandlingWith: pictureNode)
                    self.pictures.append(picture)
                    // Boolean method checks if Album exists for each picture's AlbumID
                    let containsAlbum = self.albums.contains(where: { (album) in
                        if album.albumID == picture.albumID { return true }
                        return false
                    })
                    
                    // If no correlating Album is found, create a new one; otherwise add it to the corresponding Album
                    if containsAlbum == false {
                        let newAlbum = Album(albumID: picture.albumID, pictures: [picture], albumThumbnailURL: nil)
                        self.albums.append(newAlbum)
                    } else {
                        for (index, album) in self.albums.enumerated() {
                            if album.albumID == picture.albumID {
                                self.albums[index].pictures.append(picture)
                            }
                        }
                    }
                } catch let error {
                    print("error initializing DataStore: \(error)")                    
                }
            }
            
            /*
 
            // Older initialization without error handling
             
            for pictureNode in pictureDictionary.map({ Picture(json: $0) }) {
                if let picture = pictureNode {
                    store.pictures.append(picture)
                    
                    // Boolean method checks if Album exists for each picture's AlbumID
                    let containsAlbum = store.albums.contains(where: { (album) in
                        if album.albumID == picture.albumID { return true }
                        return false
                    })
                    
                    // If no correlating Album is found, create a new one; otherwise add it to the corresponding Album
                    if containsAlbum == false {
                        let newAlbum = Album(albumID: picture.albumID, pictures: [picture], albumThumbnailURL: nil)
                        store.albums.append(newAlbum)
                    } else {
                        for (index, album) in store.albums.enumerated() {
                            if album.albumID == picture.albumID {
                                store.albums[index].pictures.append(picture)
                                
                            }
                        }
                    }
                }
            }
            */
        }
    }
    
    
}
