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
        return store.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PictureViewCell
        
        let picture = store.pictures[indexPath.row]
        DispatchQueue.main.async {
            cell.imageView.download(from: picture.thumbnailURL, contentMode: .center)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let picture = store.pictures[indexPath.row]

        let pictureDetailView = PictureDetailView(picture: picture)
        addSubview(pictureDetailView)
        pictureDetailView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.centerY.equalToSuperview()
        }
        
        
    }
    
}
/*
extension PrimaryCollectionView: UICollectionViewDelegateFlowLayout {
    func configureLayout(){
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        
        itemSize = CGSize(width: ((width - 12) / 3), height: ((height - 16) / 4))
        numberOfRows = 4
        numberOfColumns = 3
        spacing = 2
        sectionInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        referenceSize = CGSize(width: width, height: 60)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return referenceSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return referenceSize
    }
    
}
*/
