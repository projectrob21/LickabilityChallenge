//
//  WebCallDelegates.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/11/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

protocol ErrorAlertDelegate {
    
    func presentErrorAlert(error: NSError?)
    
}

protocol ReloadDataDelegate {
    
    func reloadData()
    
}
