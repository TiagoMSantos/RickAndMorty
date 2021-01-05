//
//  CharacterDetailViewController.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 25/11/20.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class CharacterDetailViewController: BaseViewController {
    
    // MARK: Variables
    private let viewModel: CharacterDetailViewModel
    private let character: Character
    
    private let scrollView: UIScrollView = {
        $0.backgroundColor = #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
        $0.isScrollEnabled = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    private let avatarImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
        $0.backgroundColor = #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let idLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        $0.textColor = #colorLiteral(red: 0.7724891305, green: 0.7725827694, blue: 0.7724573016, alpha: 1)
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let titleLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Medium", size: 26)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        return $0
    }(UILabel())
    
    private let statusHintLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        $0.text = "Status:"
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let statusValueLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let spaciesHintLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        $0.text = "Spacies:"
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let spaciesValueLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        return $0
    }(UILabel())
    
    private let typeHintLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        $0.text = "Type:"
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let typeValueLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        return $0
    }(UILabel())
    
    private let genderHintLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        $0.text = "Gender:"
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let genderValueLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        return $0
    }(UILabel())
    
    private let originHintLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        $0.text = "Origin:"
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let originValueLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        return $0
    }(UILabel())
    
    private let locationHintLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        $0.text = "Last known location:"
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let locationValueLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        return $0
    }(UILabel())
    
    private let episodesHintLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        $0.text = "Episodes:"
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let episodesValueLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        return $0
    }(UILabel())
    
    private let firstEpisodeHintLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        $0.text = "First seen in:"
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let firstEpisodeValueLabel: UILabel = {
        $0.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        return $0
    }(UILabel())
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func loadView() {
        super.loadView()
        setupObservers(viewModel: viewModel)
        setupScrollView()
        setupAvatarImageView()
        setupIdLabel()
        setupTitle()
        setupStatusLabel()
        setupSpeciesLabel()
        setupTypeLabel()
        setupGenderLabel()
        setupOriginLabel()
        setupLocationLabel()
        setupEpisodesLabel()
        setupFirstEpisodeLabel()
    }
    
    init(viewModel: CharacterDetailViewModel, character: Character) {
        self.viewModel = viewModel
        self.character = character
        viewModel.getImage(url: character.image)
        viewModel.getEpisode(url: character.episode.first!)
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Some stuff happened")
    }
    
    // MARK: Setup
    private func setupObservers(viewModel: CharacterDetailViewModel) {
        viewModel
            .imagePublishSubject
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (image) in
                self.avatarImageView.image = image
            })
            .disposed(by: disposeBag)
        
        viewModel
            .firstEpisodeNamePublishSubject
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (episode) in
                self.firstEpisodeValueLabel.text = episode
            })
            .disposed(by: disposeBag)
        
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        let marginTop = NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        let marginLeft = NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0)
        let marginRight = NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0)
        let marginBottom = NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let height = NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0)
        
        let width = NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([marginTop, marginLeft, marginRight, marginBottom, height, width])
    }
    
    private func setupAvatarImageView() {
        scrollView.addSubview(avatarImageView)
        
        let marginTop = NSLayoutConstraint(item: avatarImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        let marginLeft = NSLayoutConstraint(item: avatarImageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0)
        let marginRight = NSLayoutConstraint(item: avatarImageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0)
        
        let aspectRatio = NSLayoutConstraint(item: avatarImageView, attribute: .height, relatedBy: .equal, toItem: avatarImageView, attribute: .width, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([marginTop, marginLeft, marginRight, aspectRatio])
    }
    
    private func setupIdLabel() {
        scrollView.addSubview(idLabel)
        idLabel.text = String(format: "#%03d", character.id)
        
        let marginTop = NSLayoutConstraint(item: idLabel, attribute: .top, relatedBy: .equal, toItem: avatarImageView, attribute: .bottom, multiplier: 1.0, constant: 12)
        
        let marginLeft = NSLayoutConstraint(item: idLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 24)
        
        NSLayoutConstraint.activate([marginTop, marginLeft])
    }
    
    private func setupTitle() {
        scrollView.addSubview(titleLabel)
        titleLabel.text = character.name
        
        let marginTop = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: idLabel, attribute: .bottom, multiplier: 1.0, constant: 4)
        let marginLeft = NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant:24)
        let marginRight = NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant:-24)
        
        NSLayoutConstraint.activate([marginTop, marginLeft, marginRight])
    }
    
    private func setupStatusLabel() {
        scrollView.addSubview(statusHintLabel)
        scrollView.addSubview(statusValueLabel)
        statusValueLabel.text = character.status
        
        let hintMarginTop = NSLayoutConstraint(item: statusHintLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 24)
        let hintMarginValue = NSLayoutConstraint(item: statusValueLabel, attribute: .top, relatedBy: .equal, toItem: statusHintLabel, attribute: .top, multiplier: 1.0, constant: 0)
        let hintMarginLeft = NSLayoutConstraint(item: statusHintLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant:24)
        let valueMarginLeft = NSLayoutConstraint(item: statusValueLabel, attribute: .left, relatedBy: .equal, toItem: statusHintLabel, attribute: .right, multiplier: 1.0, constant:4)
        
        NSLayoutConstraint.activate([hintMarginTop, hintMarginValue, hintMarginLeft, valueMarginLeft])
    }
    
    private func setupSpeciesLabel() {
        scrollView.addSubview(spaciesHintLabel)
        scrollView.addSubview(spaciesValueLabel)
        spaciesValueLabel.text = character.species
        
        let hintMarginTop = NSLayoutConstraint(item: spaciesHintLabel, attribute: .top, relatedBy: .equal, toItem: statusHintLabel, attribute: .bottom, multiplier: 1.0, constant: 8)
        let hintMarginValue = NSLayoutConstraint(item: spaciesValueLabel, attribute: .top, relatedBy: .equal, toItem: spaciesHintLabel, attribute: .top, multiplier: 1.0, constant: 0)
        let hintMarginLeft = NSLayoutConstraint(item: spaciesHintLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant:24)
        let valueMarginLeft = NSLayoutConstraint(item: spaciesValueLabel, attribute: .left, relatedBy: .equal, toItem: spaciesHintLabel, attribute: .right, multiplier: 1.0, constant:4)
        
        NSLayoutConstraint.activate([hintMarginTop, hintMarginValue, hintMarginLeft, valueMarginLeft])
    }
    
    
    private func setupTypeLabel() {
        scrollView.addSubview(typeHintLabel)
        scrollView.addSubview(typeValueLabel)
        typeValueLabel.text = character.type
        
        let hintMarginTop = NSLayoutConstraint(item: typeHintLabel, attribute: .top, relatedBy: .equal, toItem: spaciesHintLabel, attribute: .bottom, multiplier: 1.0, constant: 8)
        let hintMarginValue = NSLayoutConstraint(item: typeValueLabel, attribute: .top, relatedBy: .equal, toItem: typeHintLabel, attribute: .top, multiplier: 1.0, constant: 0)
        let hintMarginLeft = NSLayoutConstraint(item: typeHintLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant:24)
        let valueMarginLeft = NSLayoutConstraint(item: typeValueLabel, attribute: .left, relatedBy: .equal, toItem: typeHintLabel, attribute: .right, multiplier: 1.0, constant:4)
        
        NSLayoutConstraint.activate([hintMarginTop, hintMarginValue, hintMarginLeft, valueMarginLeft])
    }
    
    private func setupGenderLabel() {
        scrollView.addSubview(genderHintLabel)
        scrollView.addSubview(genderValueLabel)
        genderValueLabel.text = character.gender
        
        let hintMarginTop = NSLayoutConstraint(item: genderHintLabel, attribute: .top, relatedBy: .equal, toItem: typeHintLabel, attribute: .bottom, multiplier: 1.0, constant: 8)
        let hintMarginValue = NSLayoutConstraint(item: genderValueLabel, attribute: .top, relatedBy: .equal, toItem: genderHintLabel, attribute: .top, multiplier: 1.0, constant: 0)
        let hintMarginLeft = NSLayoutConstraint(item: genderHintLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant:24)
        let valueMarginLeft = NSLayoutConstraint(item: genderValueLabel, attribute: .left, relatedBy: .equal, toItem: genderHintLabel, attribute: .right, multiplier: 1.0, constant:4)
        
        NSLayoutConstraint.activate([hintMarginTop, hintMarginValue, hintMarginLeft, valueMarginLeft])
    }
    
    private func setupOriginLabel() {
        scrollView.addSubview(originHintLabel)
        scrollView.addSubview(originValueLabel)
        originValueLabel.text = character.origin?.name
        
        let hintMarginTop = NSLayoutConstraint(item: originHintLabel, attribute: .top, relatedBy: .equal, toItem: genderHintLabel, attribute: .bottom, multiplier: 1.0, constant: 8)
        let hintMarginValue = NSLayoutConstraint(item: originValueLabel, attribute: .top, relatedBy: .equal, toItem: originHintLabel, attribute: .top, multiplier: 1.0, constant: 0)
        let hintMarginLeft = NSLayoutConstraint(item: originHintLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant:24)
        let valueMarginLeft = NSLayoutConstraint(item: originValueLabel, attribute: .left, relatedBy: .equal, toItem: originHintLabel, attribute: .right, multiplier: 1.0, constant:4)
        
        NSLayoutConstraint.activate([hintMarginTop, hintMarginValue, hintMarginLeft, valueMarginLeft])
    }
    
    private func setupLocationLabel() {
        scrollView.addSubview(locationHintLabel)
        scrollView.addSubview(locationValueLabel)
        locationValueLabel.text = character.location?.name
        
        let hintMarginTop = NSLayoutConstraint(item: locationHintLabel, attribute: .top, relatedBy: .equal, toItem: originHintLabel, attribute: .bottom, multiplier: 1.0, constant: 8)
        let hintMarginValue = NSLayoutConstraint(item: locationValueLabel, attribute: .top, relatedBy: .equal, toItem: locationHintLabel, attribute: .top, multiplier: 1.0, constant: 0)
        let hintMarginLeft = NSLayoutConstraint(item: locationHintLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant:24)
        let valueMarginLeft = NSLayoutConstraint(item: locationValueLabel, attribute: .left, relatedBy: .equal, toItem: locationHintLabel, attribute: .right, multiplier: 1.0, constant:4)
        
        NSLayoutConstraint.activate([hintMarginTop, hintMarginValue, hintMarginLeft, valueMarginLeft])
    }
    
    private func setupEpisodesLabel() {
        scrollView.addSubview(episodesHintLabel)
        scrollView.addSubview(episodesValueLabel)
        episodesValueLabel.text = character.episode.count.description
        
        let hintMarginTop = NSLayoutConstraint(item: episodesHintLabel, attribute: .top, relatedBy: .equal, toItem: locationHintLabel, attribute: .bottom, multiplier: 1.0, constant: 8)
        let hintMarginValue = NSLayoutConstraint(item: episodesValueLabel, attribute: .top, relatedBy: .equal, toItem: episodesHintLabel, attribute: .top, multiplier: 1.0, constant: 0)
        let hintMarginLeft = NSLayoutConstraint(item: episodesHintLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant:24)
        let valueMarginLeft = NSLayoutConstraint(item: episodesValueLabel, attribute: .left, relatedBy: .equal, toItem: episodesHintLabel, attribute: .right, multiplier: 1.0, constant:4)
        
        NSLayoutConstraint.activate([hintMarginTop, hintMarginValue, hintMarginLeft, valueMarginLeft])
    }
    
    private func setupFirstEpisodeLabel() {
        scrollView.addSubview(firstEpisodeHintLabel)
        scrollView.addSubview(firstEpisodeValueLabel)
        
        let hintMarginTop = NSLayoutConstraint(item: firstEpisodeHintLabel, attribute: .top, relatedBy: .equal, toItem: episodesHintLabel, attribute: .bottom, multiplier: 1.0, constant: 8)
        let hintMarginValue = NSLayoutConstraint(item: firstEpisodeValueLabel, attribute: .top, relatedBy: .equal, toItem: firstEpisodeHintLabel, attribute: .top, multiplier: 1.0, constant: 0)
        let hintMarginLeft = NSLayoutConstraint(item: firstEpisodeHintLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant:24)
        let valueMarginLeft = NSLayoutConstraint(item: firstEpisodeValueLabel, attribute: .left, relatedBy: .equal, toItem: firstEpisodeHintLabel, attribute: .right, multiplier: 1.0, constant:4)
        
        NSLayoutConstraint.activate([hintMarginTop, hintMarginValue, hintMarginLeft, valueMarginLeft])
    }
}
