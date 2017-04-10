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
    var pictureCollectionVC: PictureCollectionViewController!
    
    //    var primaryCollectionView: PrimaryCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JSONParser.populatePicturesFromDictionary()
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
            $0.leading.bottom.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}


extension AlbumCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AlbumViewCell
        let album = self.store.albums[indexPath.row]

        UIView.animate(withDuration: 2.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {

            cell.viewModel = AlbumViewCell.ViewModel(album: album)

        }, completion: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
                        cell!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        
        }, completion: { finished in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                    cell!.transform = CGAffineTransform(scaleX: 1, y: 1)
                let album = self.store.albums[indexPath.row]
                self.presentNewViewController(for: album)

            
            }, completion: nil) }
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        var size: CGSize!
        
        //*** Hard coded...
        //        let picture = store.albums[indexPath.row].pictures[0]
        
        //        DispatchQueue.main.async {
        //            let imageView = UIImageView()
        //            imageView.download(from: picture.imageURL, contentMode: .scaleAspectFit)
        //            size = imageView.image?.size
        //        }
        size = CGSize(width: 100, height: 100)
        return size
    }
    
}

// MARK: Present DetailView
extension AlbumCollectionViewController {
    
    
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
