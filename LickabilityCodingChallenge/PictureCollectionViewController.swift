//
//  PictureCollectionViewController.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/5/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class PictureCollectionViewController: UIViewController {
    
    
    var collectionView: UICollectionView!
    var album: Album?
    var parentVC: HomeCollectionViewController?
    var pictureDetailView: PictureDetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // Do any additional setup after loading the view.
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
        
        //        cell.backgroundColor = UIColor().generateRandomColor()
        
        let picture = album?.pictures[indexPath.row]
        DispatchQueue.main.async {
            cell.imageView.download(from: picture?.thumbnailURL, contentMode: .center)
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
}

