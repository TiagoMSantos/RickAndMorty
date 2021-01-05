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
    
    let avatarImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
        $0.backgroundColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    let idLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        $0.textColor = #colorLiteral(red: 0.7724891305, green: 0.7725827694, blue: 0.7724573016, alpha: 1)
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let nameLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let situationLabel: UIPaddingLabel = {
        $0.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.backgroundColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIPaddingLabel(withInsets: 4, 4, 10, 10))
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupShadowView()
        setupCardView()
        setupAvatarImageView()
        setupIdLabel()
        setupNameLabel()
        setupSituationLabel()
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
    
    private func setupAvatarImageView() {
        cardView.addSubview(avatarImageView)
        
        let marginTop = NSLayoutConstraint(item: avatarImageView, attribute: .top, relatedBy: .equal, toItem: cardView, attribute: .top, multiplier: 1.0, constant: 0)
        let marginLeft = NSLayoutConstraint(item: avatarImageView, attribute: .left, relatedBy: .equal, toItem: cardView, attribute: .left, multiplier: 1.0, constant: 0)
        let marginBottom = NSLayoutConstraint(item: avatarImageView, attribute: .bottom, relatedBy: .equal, toItem: cardView, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let aspectRatio = NSLayoutConstraint(item: avatarImageView, attribute: .width, relatedBy: .equal, toItem: avatarImageView, attribute: .height, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([marginTop, marginLeft, marginBottom, aspectRatio])
    }
    
    private func setupIdLabel() {
        cardView.addSubview(idLabel)
        
        let marginTop = NSLayoutConstraint(item: idLabel, attribute: .top, relatedBy: .equal, toItem: cardView, attribute: .top, multiplier: 1.0, constant: 12)
        
        let marginLeft = NSLayoutConstraint(item: idLabel, attribute: .left, relatedBy: .equal, toItem: avatarImageView, attribute: .right, multiplier: 1.0, constant: 24)
        
        NSLayoutConstraint.activate([marginTop, marginLeft])
    }
    
    private func setupNameLabel() {
        cardView.addSubview(nameLabel)
        
        let marginTop = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: idLabel, attribute: .bottom, multiplier: 1.0, constant: 4)
        let marginLeft = NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: avatarImageView, attribute: .right, multiplier: 1.0, constant: 24)
        let marginRight = NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: cardView, attribute: .right, multiplier: 1.0, constant:-24)
        NSLayoutConstraint.activate([marginTop, marginLeft, marginRight])
    }
    
    private func setupSituationLabel() {
        cardView.addSubview(situationLabel)
        
        let marginTop = NSLayoutConstraint(item: situationLabel, attribute: .top, relatedBy: .equal, toItem: (nameLabel), attribute: .bottom, multiplier: 1.0, constant: 12)
        let marginLeft = NSLayoutConstraint(item: situationLabel, attribute: .left, relatedBy: .equal, toItem: avatarImageView, attribute: .right, multiplier: 1.0, constant: 24)
        NSLayoutConstraint.activate([marginTop, marginLeft])
    }
    
    func configureWith(_ viewModel: CharacterTableViewCellViewModel, character: Character) {
        viewModel.getImage(url: character.image)
        setupData(character: character)
        setupObservers(viewModel: viewModel)
    }
    
    private func setupData(character: Character) {
        nameLabel.text = character.name
        idLabel.text = String(format: "#%03d", character.id)
        situationLabel.text = character.status
        
    }
    
    private func setupObservers(viewModel: CharacterTableViewCellViewModel) {
        viewModel
            .imagePublishSubject
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (image) in
                self.avatarImageView.image = image
            })
            .disposed(by: disposeBag)
    }
}
