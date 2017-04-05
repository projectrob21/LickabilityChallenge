//
//  ViewController.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import CoreData

class HomeCollectionViewController: UIViewController {
    
    let store = DataStore.shared
    var collectionView: UICollectionView!
    var pictureCollectionVC: PictureCollectionViewController!

//    var primaryCollectionView: PrimaryCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JSONParser.populatePicturesFromDictionary()
        print("number of pictures in store.pictures = \(store.pictures.count)")
        print("number of albums in store.albums = \(store.albums.count)")
        
        DispatchQueue.main.async {
            let spacing: CGFloat = 20
            let layout = UICollectionViewFlowLayout()
            
            // default size for cells
            layout.itemSize = CGSize(width: 60, height: 60)
            // The minimum spacing to use between LINES (up/down) of items in the grid.
            layout.minimumLineSpacing = spacing
            // The minimum spacing to use between items in the same ROW (left/right).
            layout.minimumInteritemSpacing = spacing / 2
            // The margins used to lay out content in a section
            layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing, spacing)
            
            self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.register(PictureViewCell.self, forCellWithReuseIdentifier: "Cell")
            
            self.view.addSubview(self.collectionView)
            self.collectionView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        
        // Download async in background?
        // Only intialize parts of json?
        // How to handle different views
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}


extension HomeCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PictureViewCell
        
        let album = store.albums[indexPath.row]
        cell.backgroundColor = UIColor().generateRandomColor()
        cell.titleLabel.text = "\(album.albumID)"
        //        let picture = store.pictures[indexPath.row]
        //        DispatchQueue.main.async {
        //            cell.imageView.download(from: picture.thumbnailURL, contentMode: .center)
        //        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = store.albums[indexPath.row]
        presentNewViewController(for: album)
    }
    
}

// MARK: Present DetailView
extension HomeCollectionViewController {
    
    
    // *** IS THIS EVEN CORRECT??
    func presentNewViewController(for album: Album) {
        pictureCollectionVC = PictureCollectionViewController()
        pictureCollectionVC.album = album
        pictureCollectionVC.parentVC = self

        /*
        pictureCollectionVC.modalPresentationStyle = .fullScreen
        pictureCollectionVC.modalTransitionStyle = .crossDissolve

        // Presenting VC
        present(pictureCollectionVC, animated: true)
        
        // showing VC
//        show(pictureCollectionVC, sender: nil)
//        showDetailViewController(pictureCollectionVC, sender: nil)
        */
        
        view.addSubview(pictureCollectionVC.view)
        pictureCollectionVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        pictureCollectionVC.didMove(toParentViewController: nil)
        view.layoutIfNeeded()
 
    }
    
    func dismissPictureVC() {
        print("dismiss tapped in home VC")
        willMove(toParentViewController: nil)
        pictureCollectionVC.view.removeFromSuperview()
        pictureCollectionVC = nil

    }
    
}
