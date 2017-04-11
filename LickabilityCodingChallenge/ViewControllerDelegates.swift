//
//  ViewControllerDelegates.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/11/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

protocol PresentDismissVCDelegate {
    
    func presentViewController(for album: Album)
    
    func presentViewController(for picture: Picture)
    
    func dismissViewController()
    
}
