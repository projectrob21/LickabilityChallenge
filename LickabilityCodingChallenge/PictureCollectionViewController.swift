//
//  PictureCollectionViewController.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/5/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SDWebImage

class PictureCollectionViewController: UIViewController {
    
    var album: Album?
    var pictureCollectionView: PictureCollectionView!
    
    var wasPresentedError = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configure()
        constrain()
    }
    
    func configure() {
        if album != nil {
            pictureCollectionView = PictureCollectionView(album: album!)
            pictureCollectionView.viewModel.viewControllerDelegate = self
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
extension PictureCollectionViewController: NewViewControllerDelegate {
    
    func presentViewController(for picture: Picture) {
        print("presentViewController for picture tapped in PictureCollection VC")

        let pictureDetailViewController = PictureDetailViewController()
        pictureDetailViewController.picture = picture
        
        pictureDetailViewController.modalPresentationStyle = .overFullScreen
        pictureDetailViewController.modalTransitionStyle = .crossDissolve
        present(pictureDetailViewController, animated: true, completion: nil)
    }
    
    func presentViewController(for album: Album) {
        print("")
    }
    
    func dismissViewController() {
        print("dismiss tapped in PictureCollection VC")
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: Error handles for if no internet connection
extension PictureCollectionViewController {
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

