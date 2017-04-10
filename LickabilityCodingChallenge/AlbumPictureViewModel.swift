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
    
    let store = DataStore.shared
    
    var viewControllerDelegate: PresentDismissVCDelegate?
    var errorAlertDelegate: ErrorAlertDelegate?
        
}

// TODO: Separate out delegates
protocol PresentDismissVCDelegate {
    
    func presentViewController(for album: Album)
    
    func presentViewController(for picture: Picture)
    
    func dismissViewController()
    
}

protocol ErrorAlertDelegate {
    
    func presentErrorAlert(error: NSError?)
    
}
