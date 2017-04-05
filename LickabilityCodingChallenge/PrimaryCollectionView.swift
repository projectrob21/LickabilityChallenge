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

class PrimaryCollectionView: UIView {
    
    let store = DataStore.shared
    var collectionView: UICollectionView!
    var pictureDetailView: PictureDetailView?
    
    // Add ScrollView behind CollectionView to enhance movements and depth
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
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
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PictureViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

    
}

extension PrimaryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PictureViewCell

        let album = store.albums[indexPath.row]
        cell.backgroundColor = UIColor().generateRandomColor()
        
//        let picture = store.pictures[indexPath.row]
//        DispatchQueue.main.async {
//            cell.imageView.download(from: picture.thumbnailURL, contentMode: .center)
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let picture = store.pictures[indexPath.row]
        presentDetailView(for: picture)
    }
    
}

// MARK: Present DetailView
extension PrimaryCollectionView {
    
    func presentDetailView(for picture: Picture) {
        pictureDetailView = PictureDetailView(picture: picture)
        
        if let pictureDetailView = pictureDetailView {
            pictureDetailView.dismissButton.addTarget(self, action: #selector(dismissDetailView), for: .touchUpInside)
            addSubview(pictureDetailView)
            pictureDetailView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
    }
    
    func dismissDetailView() {
        if let pictureDetailView = pictureDetailView {
            pictureDetailView.removeFromSuperview()
            self.pictureDetailView = nil
        }
    }
    
}
