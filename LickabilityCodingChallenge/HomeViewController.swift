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
    var primaryView: PrimaryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JSONParser.populatePicturesFromDictionary()
        
        DispatchQueue.main.async {
            print("There are currently \(self.store.pictures.count) pictures in the DataStore")
            self.primaryView = PrimaryView()
            self.view.addSubview(self.primaryView)
            self.primaryView.snp.makeConstraints {
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

/*
 albumId: 1,
 id: 1,
 title: "accusamus beatae ad facilis cum similique qui sunt",
 url: "http://placehold.it/600/92c952",
 thumbnailUrl: "http://placehold.it/150/92c952"
 */
