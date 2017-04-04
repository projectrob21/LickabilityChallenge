//
//  ViewController.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    let store = DataStore.shared
    var primaryCollectionView: PrimaryCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JSONParser.populatePicturesFromDictionary()
        
        DispatchQueue.main.async {
            print("There are currently \(self.store.pictures.count) pictures in the DataStore")
            self.primaryCollectionView = PrimaryCollectionView()
            self.view.addSubview(self.primaryCollectionView)
            self.primaryCollectionView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        
        // Download async in background?
        // Only intialize parts of json?
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
