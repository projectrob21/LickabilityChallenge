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
    
    // ScrollView behind CollectionView to enhance movements and depth
    
    var collectionView: UICollectionView!
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 111, height: 111)
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        
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
        print("cells = \(store.pictures.count)")
        return store.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PictureViewCell
        
        let picture = store.pictures[indexPath.row]
        
        cell.imageView.download(from: picture.thumbnailURL, contentMode: .center)

        cell.titleLabel.text = picture.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let picture = store.pictures[indexPath.row]

        let pictureDetailView = PictureDetailView(picture: picture)
        addSubview(pictureDetailView)
        pictureDetailView.snp.makeConstraints {
            $0.width.height.equalToSuperview().dividedBy(2)
            $0.centerX.centerY.equalToSuperview()
        }
        
        
    }
    
}
