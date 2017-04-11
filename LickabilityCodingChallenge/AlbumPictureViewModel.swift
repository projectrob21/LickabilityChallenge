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
