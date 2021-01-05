//
//  BaseViewController.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 25/11/20.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()
        view.backgroundColor = #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
    }
}
