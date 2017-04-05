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
    var textView: UIView!
    var titleLabel: UILabel!
    var dismissButton: UIButton!
        
    
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
        
        textView = UIView()
        textView.backgroundColor = UIColor.cyan
        textView.layer.cornerRadius = 10
        
        titleLabel = UILabel()
        titleLabel.text = picture.title
        titleLabel.textAlignment = .natural
//        titleLabel.adjustsFontSizeToFitWidth = true
        
        dismissButton = UIButton()
        dismissButton.setTitle("OK", for: .normal)
        dismissButton.backgroundColor = UIColor.purple
        
        backgroundColor = UIColor.blue
        
    }
    
    func constrain() {
        let paddingLeadingTop: CGFloat = UIScreen.main.bounds.width * 0.1
        let paddingTrailingBottom: CGFloat = (paddingLeadingTop * -1)
        
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.top.equalToSuperview().offset(paddingLeadingTop)
            $0.trailing.equalToSuperview().offset(paddingTrailingBottom)
            $0.height.equalTo(imageView.snp.width)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(imageView.snp.width).multipliedBy(0.85)
        }
        
        addSubview(textView)
        textView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(imageView.snp.width).multipliedBy(0.9)
            $0.top.equalTo(imageView.snp.bottom).offset(-10)
            $0.height.equalTo(titleLabel.snp.height).multipliedBy(3)
        }
        
        addSubview(dismissButton)
        dismissButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalToSuperview().dividedBy(2)
        }
        
        bringSubview(toFront: imageView)
        bringSubview(toFront: titleLabel)
    }
    
    
}
