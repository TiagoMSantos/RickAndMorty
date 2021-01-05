//
//  EpisodeTableViewCell.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 01/12/20.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class EpisodeTableViewCell: UITableViewCell {
    
    // MARK: Variables
    private var disposeBag = DisposeBag()
    
    private let cardView: UIView = {
        $0.setupCardView(view: $0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let shadowView: UIView = {
        $0.setupShadow(view: $0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupShadowView()
        setupCardView()
        selectionStyle = UITableViewCell.SelectionStyle.none
        contentView.backgroundColor = #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    // MARK: Setup
    private func setupShadowView() {
        contentView.addSubview(shadowView)
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4.0),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            contentView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: 8.0),
            contentView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: 4.0)
        ])
    }
    
    private func setupCardView() {
        
        shadowView.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 8.0),
            cardView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 8.0),
            shadowView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 8.0),
            shadowView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 8.0)
        ])
    }
    
}
