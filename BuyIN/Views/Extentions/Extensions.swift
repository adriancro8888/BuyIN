//
//  Extensions.swift
//  BuyIN
//
//  Created by Akram Elhayani on 10/03/2022.
//

import Foundation
import UIKit
extension UIView {
    
//
//
//    @IBInspectable var   shadowColor : UIColor? {
//        set{
//            layer.shadowColor = newValue?.cgColor
//            ApplyShadow()
//        }
//        get {
//            return UIColor.init(cgColor: layer.shadowColor!)
//        }
//    }
//    @IBInspectable var   shadowOpacity : Float {
//        set{
//            layer.shadowOpacity = newValue
//            ApplyShadow()
//        }
//        get {
//            return layer.shadowOpacity
//        }
//    }
//    @IBInspectable var   shadowRadius : CGFloat {
//        set{
//            layer.shadowRadius = newValue
//            ApplyShadow()
//        }
//        get {
//            return layer.shadowRadius
//        }
//    }
//    @IBInspectable var   shadowOffset : CGSize {
//        set{
//            layer.shadowOffset = newValue
//            ApplyShadow()
//        }
//        get {
//            return layer.shadowOffset
//        }
//    }
//
//
//    func ApplyShadow(){
//
//        if dropShadow {
//            layer.shadowColor = shadowColor?.cgColor
//            layer.shadowOpacity = shadowOpacity
//            layer.shadowRadius = shadowRadius
//            layer.shadowOffset = shadowOffset
//            layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//
//
//        } else {
//            layer.shadowColor = UIColor.clear.cgColor
//            layer.shadowOpacity = 0
//            layer.shadowRadius = 0
//            layer.shadowOffset = CGSize.zero
//        }
//    }
//
//    @IBInspectable var dropShadow: Bool {
//        set{
//            if   layer.shadowOpacity == 0
//            {
//                layer.shadowOpacity = 0.5
//            }
//            ApplyShadow()
//        }
//        get {
//            return   layer.shadowOpacity > 0
//        }
//    }
//
//
//
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadowOpacity > 0 {
               // self.layer.masksToBounds = true
            }
        }
    }
    
    
}

@IBDesignable extension UIView {
    @IBInspectable var shadowColor: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get{
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }

    @IBInspectable var shadowOpacity: Float{
        set {
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
    }

    @IBInspectable var shadowOffset: CGSize{
        set {
            layer.shadowOffset = newValue
        }
        get{
            return layer.shadowOffset
        }
    }

    @IBInspectable var shadowRadius: CGFloat{
        set {
            layer.shadowRadius = newValue
        }
        get{
            return layer.shadowRadius
        }
    }
}
