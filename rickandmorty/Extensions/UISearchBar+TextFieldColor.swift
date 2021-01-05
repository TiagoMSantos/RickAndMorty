//
//  UISearchBar+TextFieldColor.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 30/11/20.
//

import Foundation
import UIKit

extension UISearchBar {
    func changeSearchBarColor(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContext(self.frame.size)
        color.setFill()
        UIBezierPath(rect: self.frame).fill()
        let bgImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setSearchFieldBackgroundImage(bgImage, for: .normal)
    }
}
