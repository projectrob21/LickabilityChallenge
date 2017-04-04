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
    
    
    var sectionInsets: UIEdgeInsets!
    var spacing: CGFloat!
    var itemSize: CGSize!
    var referenceSize: CGSize!
    var numberOfRows: CGFloat!
    var numberOfColumns: CGFloat!
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)

//        configureLayout()
        

        
        
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
            $0.width.height.equalToSuperview().dividedBy(2)
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
