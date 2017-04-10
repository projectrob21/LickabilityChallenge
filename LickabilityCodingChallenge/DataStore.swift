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
        
        let store = DataStore.shared
        
        JSONParser.getDictionary(from: "photos") { pictureDictionary in
            
            // *** REFACTOR FOR LOOPS & ALBUMS, *** Error-Handling Initializer
            /*
             for pictureNode in pictureDictionary {
             do {
             let picture = try Picture(errorHandlingWith: pictureNode)
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
             } catch {
             
             }
             }
             */
            
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
        }
    }
    
    
}
