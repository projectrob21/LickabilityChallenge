//
//  PictureCollectionViewController.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/5/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SDWebImage

class PictureCollectionViewController: UIViewController, CHTCollectionViewDelegateWaterfallLayout {
    
    var album: Album?
    var parentVC: AlbumCollectionViewController?
    var pictureDetailView: PictureDetailView!
    
    var collectionView: UICollectionView!
    var blurEffectView: UIVisualEffectView!
    var windowView: UIView!
    var albumTitleView: UIView!
    var albumLabel: UILabel!
    lazy var dismissBackgroundButton = UIButton()
    
    var wasPresentedError = false


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            configure()
            constrain()
        
    }
    
    func configure() {
        guard let album = album else { print("error unwrapping album in PicVC"); return }
        print("configuring")

        // Dispatch
        
        print("setting background")
        
        view.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
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
        dismissBackgroundButton.addTarget(self, action: #selector(dismissPicturePictureCollectionView), for: .touchUpInside)
        
        let spacing: CGFloat = 20
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumInteritemSpacing = spacing
        layout.minimumColumnSpacing = spacing
        layout.columnCount = 4
        layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing, spacing)
        
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(PictureViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView.backgroundColor = UIColor.clear
    }
    
    func constrain() {
        
        let paddingLeadingTop: CGFloat = UIScreen.main.bounds.width * 0.1
        let paddingTrailingBottom: CGFloat = (paddingLeadingTop * -1)
        
        view.addSubview(blurEffectView)
        
        view.addSubview(dismissBackgroundButton)
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
        
        view.addSubview(albumTitleView)
        
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
        
        if let thumbnailString = picture?.thumbnailURL {
            let url = URL(string: thumbnailString)
            cell.imageView.sd_setImage(with: url, completed: { (returnedImage, error, wasCached, originalURL) in
                if returnedImage == nil {
                    print("\nunable to download image: \(error)")
                    cell.imageView.image = #imageLiteral(resourceName: "noImagePic")
                    if self.wasPresentedError == false {
                        self.presentErrorAlert(error: error as NSError?)
                    }
                }
            })
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let picture = album?.pictures[indexPath.row]
        presentPictureDetailView(for: picture!)
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

// MARK: Present/Dismiss views and error messages
extension PictureCollectionViewController {
    func presentPictureDetailView(for picture: Picture) {
        // *** ANIMATE
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
        // *** ANIMATE
        if let pictureDetailView = pictureDetailView {
            pictureDetailView.removeFromSuperview()
            self.pictureDetailView = nil
        }
    }
    
    func dismissPicturePictureCollectionView() {
        print("tapped")
        // if VC was presented/shown
//        self.dismiss(animated: true)
        wasPresentedError = false
        // if it was added to parent's view
        parentVC?.dismissPictureVC()
        
    }
    
    func presentErrorAlert(error: NSError?) {
        
        wasPresentedError = true
        if let error = error {
            let alertController = UIAlertController(
                title: "Unable to download images.",
                message: "\(error.localizedDescription)",
                preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

