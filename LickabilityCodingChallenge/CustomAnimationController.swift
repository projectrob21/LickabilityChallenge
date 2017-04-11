//
//  CustomAnimationController.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/11/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

class CustomAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if let toViewController = transitionContext.viewController(forKey: .to) {
            
            let container = transitionContext.containerView
            
            container.addSubview(toViewController.view)
            
            (toViewController as? PictureViewController)?.pictureCollectionView.blurEffectView.effect = nil
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                (toViewController as? PictureViewController)?.pictureCollectionView.blurEffectView.effect = UIBlurEffect(style: .regular)
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
            
        }
        
    }
    
    
    
}
