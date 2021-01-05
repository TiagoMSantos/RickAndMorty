//
//  UIView+CardView.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 26/11/20.
//

import UIKit
import Foundation

extension UIView {
    func setupShadow(view : UIView) {
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 0.10
    }
    
    func setupCardView(view: UIView) {
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
    }
}
