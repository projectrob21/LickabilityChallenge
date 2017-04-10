//
//  PictureViewModel.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/9/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

struct AlbumPictureViewModel {
    
    var viewControllerDelegate: PresentDismissVCDelegate?
    
//    func makePrimaryAlbumThumbnail(for album: Album, with picture: Picture) {
//        album.albumThumbnailURL = picture.thumbnailURL
//    }
        
}


protocol PresentDismissVCDelegate {
    
    func presentViewController(for album: Album)
    
    func presentViewController(for picture: Picture)
    
    func dismissViewController()
    
}
