//
//  PictureViewCell.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

final class AlbumViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var coverImage: UIImage?
    var titleLabel: UILabel!
    
    struct ViewModel {
        let album: Album
    }

    var viewModel: ViewModel? {
        didSet {
            titleLabel.attributedText = viewModel?.albumIDLabel
            if viewModel?.album.albumThumbnailURL == nil {
                self.backgroundColor = UIColor().generateRandomColor()
            } else {
                // TODO: If album has a designated thumbnail, load that image; otherwise assign a random UIColor
            }
        }
    }
    
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
        self.layer.cornerRadius = 20
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        titleLabel = UILabel()
        
    }
    
    func constrain() {
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
}

extension AlbumViewCell.ViewModel {
    
    var albumIDLabel: NSAttributedString {
        let formattedString: String = "\(album.albumID)"
        
        let attributedString = NSMutableAttributedString(string: formattedString)
        let nameRange = (formattedString as NSString).range(of: "\(album.albumID)")
        let nameFont = UIFont(name: "HelveticaNeue-Light", size: 20)
        
        let nameColor = UIColor.white
        attributedString.addAttributes([NSFontAttributeName: nameFont as Any, NSForegroundColorAttributeName: nameColor], range: nameRange)
        return attributedString
    }

    
    // TODO: ViewModel not necesssarily for downloading images / internet calls
    
    var albumImageView: UIImageView? {
        var coverImageView: UIImageView?
        
        if let thumbnailString = album.albumThumbnailURL {
            let url = URL(string: thumbnailString)
            coverImageView = UIImageView()
            coverImageView?.contentMode = .scaleAspectFill
            coverImageView?.sd_setImage(with: url)
            return coverImageView
        }
        return coverImageView
    }
    
}
