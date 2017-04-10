//
//  ViewController.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import CoreData

class AlbumCollectionViewController: UIViewController {
    
    let store = DataStore.shared
    var albumCollectionView: AlbumCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.populatePicturesFromDictionary()
        
        configure()
        constrain()
        
    }
    
    func configure() {
        albumCollectionView = AlbumCollectionView()
        albumCollectionView.viewModel.viewControllerDelegate = self
    }
    
    func constrain() {
        view.addSubview(albumCollectionView)
        albumCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


// MARK: Present ViewControllers
extension AlbumCollectionViewController: PresentDismissVCDelegate {
    
    // TODO This function will never be called in this VC

    func presentViewController(for picture: Picture) {
        fatalError()
    }

    func presentViewController(for album: Album) {
        let pictureCollectionVC = PictureCollectionViewController()
        pictureCollectionVC.album = album
        
        pictureCollectionVC.modalPresentationStyle = .overFullScreen
        pictureCollectionVC.modalTransitionStyle = .crossDissolve
        present(pictureCollectionVC, animated: true, completion: nil)
    }
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
}
