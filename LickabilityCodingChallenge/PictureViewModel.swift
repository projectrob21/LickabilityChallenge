//
//  PictureViewModel.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/12/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//


import Foundation
import UIKit

struct PictureViewModel {
    
    var album: Album!
    var picture: Picture!
    
    var viewControllerDelegate: PresentDismissVCDelegate?
    var errorAlertDelegate: ErrorAlertDelegate?
    var reloadDataDelegate: ReloadDataDelegate?
    
    
}
