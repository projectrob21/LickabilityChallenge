//
//  PictureDetailViewController.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/10/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

class PictureDetailViewController: UIViewController {
    
    var pictureDetailView: PictureDetailView!
    var picture: Picture?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        constrain()
        
    }
    
    func configure() {
        if let picture = picture {
            pictureDetailView = PictureDetailView()
            pictureDetailView.picture = picture
            pictureDetailView.viewModel.viewControllerDelegate = self
        }
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.lightGray
        
        let backgroundGradient = CAGradientLayer()
        backgroundGradient.colors = [color1.cgColor, color2.cgColor, color1.cgColor]
        backgroundGradient.locations = [0, 0.5, 1]
        backgroundGradient.startPoint = CGPoint(x: 0, y: 0)
        backgroundGradient.endPoint = CGPoint(x: 1, y: 0)
        backgroundGradient.frame = view.frame
        view.layer.insertSublayer(backgroundGradient, at: 0)
        
    }
    
    func constrain() {
        view.addSubview(pictureDetailView)
        pictureDetailView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension PictureDetailViewController: PresentDismissVCDelegate {
    
    // TODO: Two of these methods will never be called
    func presentViewController(for album: Album) {
        fatalError()
    }
    
    func presentViewController(for picture: Picture) {
        fatalError()
    }
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
}
