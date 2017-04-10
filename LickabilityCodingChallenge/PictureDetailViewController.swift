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
            pictureDetailView = PictureDetailView(picture: picture)
            pictureDetailView.viewModel.viewControllerDelegate = self
        }
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
    
    func presentViewController(for album: Album) {
        
        
    }
    
    func presentViewController(for picture: Picture) {
        
    }
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
}
