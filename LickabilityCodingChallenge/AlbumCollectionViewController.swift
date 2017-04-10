//
//  ViewController.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import CoreData

class AlbumCollectionViewController: UIViewController, CHTCollectionViewDelegateWaterfallLayout {
    
    let store = DataStore.shared
    var collectionView: UICollectionView!
    
    //    var primaryCollectionView: PrimaryCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.populatePicturesFromDictionary()
        print("number of pictures in store.pictures = \(store.pictures.count)")
        print("number of albums in store.albums = \(store.albums.count)")
        
        
        configure()
        constrain()
        
        // Download async in background?
        // Only intialize parts of json?
        // How to handle different views
        
        
        
    }
    
    func configure() {
        UIApplication.shared.statusBarStyle = .lightContent
        
        let spacing: CGFloat = 20
        
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumInteritemSpacing = spacing
        layout.minimumColumnSpacing = spacing
        layout.columnCount = 4
        layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing, spacing)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlbumViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func constrain() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
            $0.leading.bottom.trailing.equalToSuperview()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    var albumCollectionView: AlbumCollectionView!

    
}


extension AlbumCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AlbumViewCell
        let album = self.store.albums[indexPath.row]
        
        cell.viewModel = AlbumViewCell.ViewModel(album: album)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

//        albumCollectionView = AlbumCollectionView()
//        albumCollectionView.presentPictureCollectionVC = presentNewViewController(_:)
        
                let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
            cell!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
        }, completion: { finished in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                
                cell!.transform = CGAffineTransform(scaleX: 1, y: 1)
                
                
                let album = self.store.albums[indexPath.row]
                self.presentNewViewController(for: album)
                
                
            }, completion: nil) }
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        var size: CGSize!
        
        //"If you do not implement this method, the flow layout uses the values in its itemSize property to set the size of items instead."

        size = CGSize(width: 100, height: 100)
        return size
    }
    
}

// MARK: Present DetailView
extension AlbumCollectionViewController {
    
    
    
    // *** IS THIS EVEN CORRECT??
    func presentNewViewController(for album: Album) {
        let pictureCollectionVC = PictureCollectionViewController()
        pictureCollectionVC.album = album
        //pictureCollectionVC.parentVC = self
        
        pictureCollectionVC.modalPresentationStyle = .overFullScreen
        pictureCollectionVC.modalTransitionStyle = .crossDissolve
        present(pictureCollectionVC, animated: true, completion: nil)
        
        
        /*
         pictureCollectionVC.modalPresentationStyle = .fullScreen
         pictureCollectionVC.modalTransitionStyle = .crossDissolve
         
         // Presenting VC
         present(pictureCollectionVC, animated: true)
         
         // showing VC
         //        show(pictureCollectionVC, sender: nil)
         //        showDetailViewController(pictureCollectionVC, sender: nil)
         */
        
//        view.addSubview(pictureCollectionVC.view)
//        pictureCollectionVC.view.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        pictureCollectionVC.didMove(toParentViewController: nil)
//        view.layoutIfNeeded()
//        
    }
    
    func dismissPictureVC() {
        print("dismiss tapped in home VC")
        willMove(toParentViewController: nil)
//        pictureCollectionVC.view.removeFromSuperview()
//        pictureCollectionVC = nil
        
    }
    
}
