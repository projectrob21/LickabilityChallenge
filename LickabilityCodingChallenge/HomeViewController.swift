//
//  ViewController.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let store = DataStore.shared

    
    override func viewDidLoad() {
        super.viewDidLoad()

        JSONParser.populatePicturesFromDictionary()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("There are currently \(store.pictures.count) pictures in the DataStore")
    }


}

/*
 albumId: 1,
 id: 1,
 title: "accusamus beatae ad facilis cum similique qui sunt",
 url: "http://placehold.it/600/92c952",
 thumbnailUrl: "http://placehold.it/150/92c952"
 */
