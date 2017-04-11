//
//  ViewController.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import CoreData

class AlbumViewController: UIViewController {
    
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
extension AlbumViewController: PresentDismissVCDelegate {
    
    // TODO This function will never be called in this VC

    func presentViewController(for picture: Picture) {
        fatalError()
    }

    func presentViewController(for album: Album) {
        let pictureVC = PictureViewController()
        pictureVC.album = album
        
        pictureVC.modalPresentationStyle = .overFullScreen
        pictureVC.modalTransitionStyle = .crossDissolve
        present(pictureVC, animated: true, completion: nil)
    }
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
}
