//
//  PictureViewController.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/5/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SDWebImage

class PictureViewController: UIViewController {
    
    var album: Album?
    var pictureCollectionView: PictureCollectionView!
    
    var wasPresentedError = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        constrain()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configure() {
        if album != nil {
            pictureCollectionView = PictureCollectionView()
            pictureCollectionView.album = album
            pictureCollectionView.viewModel.viewControllerDelegate = self
            pictureCollectionView.viewModel.errorAlertDelegate = self
        }
    }
    
    func constrain() {
        view.addSubview(pictureCollectionView)
        pictureCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



// MARK: Present/Dismiss views and error messages
extension PictureViewController: PresentDismissVCDelegate {
    
    func presentViewController(for picture: Picture) {
        let pictureDetailViewController = PictureDetailViewController()
        pictureDetailViewController.picture = picture
        
        pictureDetailViewController.modalPresentationStyle = .fullScreen
        present(pictureDetailViewController, animated: true, completion: nil)
    }
    
    func presentViewController(for album: Album) {
        // TODO this method should never get called
        fatalError()
    }
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: Error handles for if no internet connection
extension PictureViewController: ErrorAlertDelegate {
    func presentErrorAlert(error: NSError?) {
        
        if wasPresentedError == false {
            if let error = error {
                let alertController = UIAlertController(
                    title: "Unable to download images",
                    message: "\(error.localizedDescription)",
                    preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "OK", style: .cancel)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: {
                    self.wasPresentedError = true
                })
            }
        }
    }
}

