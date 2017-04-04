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

class PictureDetailView: UIView {
    
    var picture: Picture!
    var imageView: UIImageView!
    var titleLabel: UILabel!
        
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    convenience init(picture: Picture) {
        self.init(frame: CGRect.zero)
        self.picture = picture

        configure()
        constrain()
        
    }
    
    func configure() {
        imageView = UIImageView()
        imageView.download(from: picture.imageURL, contentMode: .scaleAspectFit)
        
        titleLabel = UILabel()
        titleLabel.text = picture.title
        
    }
    
    func constrain() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.bottom.width.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(4)
        }
    }
    
    
    
    
    
}
