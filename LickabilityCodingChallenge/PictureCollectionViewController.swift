//
//  PictureCollectionViewController.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/5/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class PictureCollectionViewController: UIViewController {
    
    var album: Album?
    var parentVC: HomeCollectionViewController?
    var pictureDetailView: PictureDetailView!
    var collectionView: UICollectionView!
    var backgroundBlurEffect: UIBlurEffect!
    lazy var dismissBackgroundButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.configure()
            self.constrain()
        }
        
    }
    
    func configure() {
        view.backgroundColor = UIColor.clear
        dismissBackgroundButton = UIButton()
//        backgroundBlurEffect = UIBlurEffect(style: .regular)
        
        dismissBackgroundButton.addTarget(self, action: #selector(dismissPicturePictureCollectionView), for: .touchUpInside)
        
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
    }
    
    func constrain() {
        
        let paddingLeadingTop: CGFloat = UIScreen.main.bounds.width * 0.1
        let paddingTrailingBottom: CGFloat = (paddingLeadingTop * -1)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        view.addSubview(dismissBackgroundButton)
        dismissBackgroundButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dismissBackgroundButton.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.top.equalToSuperview().offset(paddingLeadingTop)
            $0.trailing.equalToSuperview().offset(paddingTrailingBottom)
            $0.height.equalTo(self.collectionView.snp.width)
        }
    }
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PictureCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let album = album {
            return album.pictures.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PictureViewCell
        
        
        let picture = album?.pictures[indexPath.row]
        DispatchQueue.main.async {
            cell.imageView.download(from: picture?.thumbnailURL, contentMode: .scaleAspectFit)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let picture = album?.pictures[indexPath.row]
        presentPictureDetailView(for: picture!)
    }
    
}

extension PictureCollectionViewController {
    func presentPictureDetailView(for picture: Picture) {
        
        pictureDetailView = PictureDetailView(picture: picture)
        
        if let pictureDetailView = pictureDetailView {
            pictureDetailView.dismissButton.addTarget(self, action: #selector(dismissDetailView), for: .touchUpInside)
            view.addSubview(pictureDetailView)
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
    
    func dismissPicturePictureCollectionView() {
        print("tapped")
        // if VC was presented/shown
//        self.dismiss(animated: true)
        
        // if it was added to parent's view
        parentVC?.dismissPictureVC()
        
    }
}

