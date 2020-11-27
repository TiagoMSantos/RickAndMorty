//
//  CharacterListCell.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 26/11/20.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class CharacterTableViewCell: UITableViewCell {
    
    // MARK: Variables
    private var disposeBag = DisposeBag()
    
    private let containerView: UIView = {
        $0.backgroundColor = UIColor.white
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 2
        $0.layer.shadowColor = UIColor(hexFromString: "#4F9BF5").cgColor
        $0.layer.shadowOffset = CGSize(width: 3, height: 3)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let stackView: UIStackView = {
        $0.axis = .horizontal
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = 24.0
        return $0
    }(UIStackView())
    
    private let avatarImageView: UIImageView = {
        $0.backgroundColor = .red
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    let nameLabel: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 21)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContainerView()
        setupStackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    // MARK: Setup
    private func setupContainerView() {
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24.0),
            contentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 24.0),
            contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 12.0)
        ])
    }
    
    private func setupStackView() {
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(avatarImageView)
        stackView.addArrangedSubview(nameLabel)
    }
}
