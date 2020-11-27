//
//  CharacterDetailViewController.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 25/11/20.
//

import UIKit
import Foundation

class CharacterDetailViewController: UIViewController {
    
    private let viewModel: CharacterDetailViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "CharacterDetailViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Some stuff happened")
    }
}
