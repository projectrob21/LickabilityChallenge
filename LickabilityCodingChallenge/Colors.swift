//
//  Colors.swift
//  Bliptronic5000
//
//  Created by Robert Deans on 3/25/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    public static let titleFont = UIColor(red: 252/255, green: 255/255, blue: 245/255, alpha: 1)
    
    public static let backgroundDark = UIColor(red: 159/255, green: 188/255, blue: 191/255, alpha: 1)
    
    public static let backgroundLight = UIColor(red: 213/255, green: 251/255, blue: 255/255, alpha: 1)
    
    public static let buttonColor = UIColor(red: 62/255, green: 96/255, blue: 111/255, alpha: 1)
    
    func generateRandomColor() -> UIColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        
        return color
    }
}


// MARK: Gradients
extension CAGradientLayer {
    convenience init(_ colors: [UIColor]) {
        self.init()
        
        self.colors = colors.map { $0.cgColor }
    }
}

extension CALayer {
    
    public static func makeGradient(firstColor: UIColor, secondColor: UIColor) -> CAGradientLayer {
        let backgroundGradient = CAGradientLayer()
        
        backgroundGradient.colors = [firstColor.cgColor, secondColor.cgColor]
        backgroundGradient.locations = [0, 1]
        backgroundGradient.startPoint = CGPoint(x: 0, y: 0)
        backgroundGradient.endPoint = CGPoint(x: 0, y: 1)
        
        return backgroundGradient
    }
}
