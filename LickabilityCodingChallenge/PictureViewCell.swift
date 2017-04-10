//
//  PictureViewCell.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

final class PictureViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
   
    // TODO: Add explanation for following code and extension
    
    /*
    struct ImageDownloadManager {
        var picture: Picture
        var errorAlertDelegate: ErrorAlertDelegate?
    }
    
    var imageDownloadManager: ImageDownloadManager? {
        didSet {
            self.imageView = UIImageView()
            self.imageView.contentMode = .scaleAspectFill
            self.imageView.image = imageDownloadManager?.imageView.image
            self.contentView.addSubview(imageView)
            imageView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constrain()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.white.cgColor
        
        self.imageView = UIImageView()
        self.imageView.contentMode = .scaleAspectFill
        
    }
    
    func constrain() {
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

/*
extension PictureViewCell.ImageDownloadManager {
    
    var imageView: UIImageView {
        
        let url = URL(string: picture.thumbnailURL)
        
        let downloadedImageView = UIImageView()
        downloadedImageView.sd_setImage(with: url, completed: { (returnedImage, error, wasCached, originalURL) in
            
            if returnedImage == nil {
                print("\nunable to download image: \(String(describing: error?.localizedDescription))")
                downloadedImageView.image = #imageLiteral(resourceName: "noImagePic")
                
                // error inherits from NSError, so is safe to case
                // TODO networking in View!!
                self.errorAlertDelegate?.presentErrorAlert(error: error as NSError?)
            }
            
        })
        return downloadedImageView
    }
}
*/
