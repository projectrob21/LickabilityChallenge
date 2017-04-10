//
//  PrimaryView.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class AlbumCollectionView: UIView {
    
    let store = DataStore.shared
    var collectionView: UICollectionView!
    var pictureCollectionVC: PictureCollectionViewController!
    var pictureDetailView: PictureDetailView?
    
//    var presentPictureCollectionVC: (Album) -> ()
    
    // Add ScrollView behind CollectionView to enhance movements and depth
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder) }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    convenience init(method: @escaping (Album) -> () ) {
        self.init()
//        presentPictureCollectionVC = method
        configure()
        constrain()
    }
    
    func configure() {
        
        let spacing: CGFloat = 20
        
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumInteritemSpacing = spacing
        layout.minimumColumnSpacing = spacing
        layout.columnCount = 4
        layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing, spacing)
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlbumViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func constrain() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
            $0.leading.bottom.trailing.equalToSuperview()
            
        }
    }
    
    
}

extension AlbumCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
            cell!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
        }, completion: { finished in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                
                cell!.transform = CGAffineTransform(scaleX: 1, y: 1)
                
                
                let album = self.store.albums[indexPath.row]
                self.presentPictureCollectionVC(album)
                
                
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
extension AlbumCollectionView {
    
//    // *** IS THIS EVEN CORRECT??
//    func presentNewViewController(for album: Album) {
//        pictureCollectionVC = PictureCollectionViewController()
//        pictureCollectionVC.album = album
//        pictureCollectionVC.parentVC = self
//        
//        /*
//         pictureCollectionVC.modalPresentationStyle = .fullScreen
//         pictureCollectionVC.modalTransitionStyle = .crossDissolve
//         
//         // Presenting VC
//         present(pictureCollectionVC, animated: true)
//         
//         // showing VC
//         //        show(pictureCollectionVC, sender: nil)
//         //        showDetailViewController(pictureCollectionVC, sender: nil)
//         */
//        
//        view.addSubview(pictureCollectionVC.view)
//        pictureCollectionVC.view.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        pictureCollectionVC.didMove(toParentViewController: nil)
//        view.layoutIfNeeded()
//        
//    }
//    
//    func dismissPictureVC() {
//        print("dismiss tapped in home VC")
//        willMove(toParentViewController: nil)
//        pictureCollectionVC.view.removeFromSuperview()
//        pictureCollectionVC = nil
//    }
    
}
