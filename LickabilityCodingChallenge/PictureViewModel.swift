//
//  PictureViewModel.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/9/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

struct PictureViewModel {
    
    var viewControllerDelegate: NewViewControllerDelegate?
    
//    func makePrimaryAlbumThumbnail(for album: Album, with picture: Picture) {
//        album.albumThumbnailURL = picture.thumbnailURL
//    }
        
}


protocol NewViewControllerDelegate {
    
    func presentViewController(for album: Album)
    
    func presentViewController(for picture: Picture)
    
    func dismissViewController()
    
}
