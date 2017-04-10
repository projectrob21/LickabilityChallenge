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
import SDWebImage

class PictureDetailView: UIView {
    
    var picture: Picture!
    var imageView: UIImageView!
    var textView: UIView!
    var titleLabel: UILabel!
    var dismissButton: UIButton!
        
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
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
        imageView.backgroundColor = UIColor.white
        
        // *** no network calls in view
        
        let url = URL(string: picture.imageURL)
        imageView.sd_setImage(with: url)
        
        textView = UIView()
        textView.backgroundColor = UIColor.lightGray
        textView.layer.cornerRadius = 10
        
        titleLabel = UILabel()
        titleLabel.text = picture.title
        titleLabel.textAlignment = .natural
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = UIFont(name: "Avenir", size: 20)
        titleLabel.textColor = UIColor.white

        // *** text alignment
        titleLabel.numberOfLines = 0
        
        dismissButton = UIButton()
        dismissButton.setTitle("OK", for: .normal)
        dismissButton.backgroundColor = UIColor.purple
        
        backgroundColor = UIColor.white
        
    }
    
    func constrain() {
        let paddingLeadingTop: CGFloat = UIScreen.main.bounds.width * 0.1
        let paddingTrailingBottom: CGFloat = (paddingLeadingTop * -1)
        
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(paddingLeadingTop)
            $0.top.equalToSuperview().offset(paddingLeadingTop + UIApplication.shared.statusBarFrame.height)
            $0.trailing.equalToSuperview().offset(paddingTrailingBottom)
            $0.height.equalTo(imageView.snp.width)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(imageView.snp.width).multipliedBy(0.80)
        }
        
        addSubview(textView)
        textView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(imageView.snp.width).multipliedBy(0.9)
            $0.top.equalTo(imageView.snp.bottom).offset(-10)
            $0.bottom.equalTo(titleLabel.snp.bottom).offset(10)
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
