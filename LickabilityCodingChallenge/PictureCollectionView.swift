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

class PictureCollectionView: UIView {
    
    let store = DataStore.shared
    var album: Album?
    var viewModel = PictureViewModel()
    
    var collectionView: UICollectionView!
    var blurEffectView: UIVisualEffectView!
    var windowView: UIView!
    var albumTitleView: UIView!
    var albumLabel: UILabel!
    lazy var dismissBackgroundButton = UIButton()
    
    var wasPresentedError = false
    
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(album: Album) {
        self.init(frame: CGRect.zero)
        self.album = album
        configure()
        constrain()
    }
    
    
    func configure() {
        guard let album = album else { print("error unwrapping album in PicVC"); return }
        
        backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        windowView = UIView()
        windowView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        windowView.layer.cornerRadius = 20
        
        albumTitleView = UIView()
        albumTitleView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        albumTitleView.layer.cornerRadius = 15
        
        albumLabel = UILabel()
        albumLabel.textColor = UIColor.white
        albumLabel.font = UIFont(name: "Avenir-Light", size: 20)
        albumLabel.textAlignment = .center
        albumLabel.text = "Album \(album.albumID)"
        
        
        dismissBackgroundButton = UIButton()
        dismissBackgroundButton.addTarget(self, action: #selector(dismissViewControllerFromDelegate), for: .touchUpInside)
        
        let spacing: CGFloat = 20
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumInteritemSpacing = spacing
        layout.minimumColumnSpacing = spacing
        layout.columnCount = 4
        layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing, spacing)
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PictureViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.clear
    }
    
    func constrain() {
        let paddingLeadingTop: CGFloat = UIScreen.main.bounds.width * 0.1
        let paddingTrailingBottom: CGFloat = (paddingLeadingTop * -1)
        
        addSubview(blurEffectView)
        
        addSubview(dismissBackgroundButton)
        dismissBackgroundButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dismissBackgroundButton.addSubview(windowView)
        windowView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(paddingLeadingTop + UIApplication.shared.statusBarFrame.height)
            $0.leading.equalToSuperview().offset(paddingLeadingTop)
            $0.trailing.equalToSuperview().offset(paddingTrailingBottom)
            $0.height.equalTo(windowView.snp.width)
        }
        
        windowView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsetsMake(2, 2, 2, 2))
        }
        
        addSubview(albumTitleView)
        
        albumTitleView.addSubview(albumLabel)
        albumLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        albumTitleView.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(windowView.snp.bottom).offset(10)
            $0.leading.equalTo(albumLabel.snp.leading).offset(-20)
            $0.trailing.equalTo(albumLabel.snp.trailing).offset(20)
            $0.bottom.equalTo(albumLabel.snp.bottom).offset(5)
        }
    }
    
    
}

extension PictureCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let album = album {
            return album.pictures.count
        }
        return 0    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PictureViewCell
        
        let picture = album?.pictures[indexPath.row]
        
        if let thumbnailString = picture?.thumbnailURL {
            let url = URL(string: thumbnailString)
            cell.imageView.sd_setImage(with: url, completed: { (returnedImage, error, wasCached, originalURL) in
                
                cell.layer.borderWidth = 1
                if returnedImage == nil {
                    print("\nunable to download image: \(String(describing: error?.localizedDescription))")
                    cell.imageView.image = #imageLiteral(resourceName: "noImagePic")
                    if self.wasPresentedError == false {
                        //     ***                  self.presentErrorAlert(error: error as NSError?)
                    }
                }
            })
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let picture = album?.pictures[indexPath.row] {
            viewModel.viewControllerDelegate?.presentViewController(for: picture)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        var size: CGSize!
        
        //"If you do not implement this method, the flow layout uses the values in its itemSize property to set the size of items instead."
        
        size = CGSize(width: 100, height: 100)
        return size
    }
    
}


extension PictureCollectionView {
    
    func dismissViewControllerFromDelegate() {
        viewModel.viewControllerDelegate?.dismissViewController()
    }
}
