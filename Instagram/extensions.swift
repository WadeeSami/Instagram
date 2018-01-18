//
//  extensions.swift
//  Instagram
//
//  Created by Wadee Sami on 1/14/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    static func rgb(red:Float, green:Float, blue:Float)->UIColor{
        return UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1.0)
    }
}


extension UIView{
    func anchor(top: NSLayoutYAxisAnchor?, left:NSLayoutXAxisAnchor?,
                right: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?,
                paddingTop: CGFloat, paddingleft: CGFloat, paddingRight:CGFloat,paddingBottom:CGFloat,
                width: CGFloat, height: CGFloat
        ){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top{
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left{
            self.leftAnchor.constraint(equalTo: left, constant: paddingleft).isActive = true
        }
        
        if let right = right{
            self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if  width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if  height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
