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
    var viewModel = PictureViewModel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder) }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
        constrain()
    }

    func configure() {
        UIApplication.shared.statusBarStyle = .lightContent
        
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
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    
}

extension AlbumCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
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
        
        let album = self.store.albums[indexPath.row]
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
                cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                
            }, completion: { finished in
                UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                    
                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                    
                    
                    self.viewModel.viewControllerDelegate?.presentViewController(for: album)
                    
                }, completion: nil) }
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        var size: CGSize!
        
        //"If you do not implement this method, the flow layout uses the values in its itemSize property to set the size of items instead."
        
        size = CGSize(width: 100, height: 100)
        return size
    }
    
}
