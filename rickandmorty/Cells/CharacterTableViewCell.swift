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
        return $0
    }(UIView())
    
    private let avatarImageView: UIImageView = {
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
        setupAvatarImageView()
        setupNameLabel()
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
        
        let marginTop = NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 12)
        let marginLeft = NSLayoutConstraint(item: containerView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 24)
        let marginRight = NSLayoutConstraint(item: containerView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: -24)
        let marginBottom = NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 12)
        
        NSLayoutConstraint.activate([marginTop, marginLeft, marginRight, marginBottom])
    }
    
    private func setupAvatarImageView() {
        contentView.addSubview(avatarImageView)
        
        let marginTop = NSLayoutConstraint(item: avatarImageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0)
        let marginLeft = NSLayoutConstraint(item: avatarImageView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 0)
        let marginBottom = NSLayoutConstraint(item: avatarImageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0)

        
        NSLayoutConstraint.activate([marginTop, marginLeft, marginBottom])
    }
    
    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        
        let marginTop = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 24)
        let marginLeft = NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: avatarImageView, attribute: .right, multiplier: 1.0, constant: 24)
        let marginRight = NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant:0)
        let marginBottom = NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([marginTop, marginLeft, marginRight, marginBottom])
    }
}
