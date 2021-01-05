//
//  CharacterListViewController.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 25/11/20.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class CharacterListViewController: BaseViewController {
    
    // MARK: Variables
    private let viewModel: CharacterListViewModel
    private var characterList: [Character] = []
    
    private let titleLabel: UILabel = {
        $0.text = "Rick And Morty App"
        $0.font = UIFont(name: "HelveticaNeue-Medium", size: 26)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        return $0
    }(UILabel())
    
    private let searchBar: UISearchBar = {
        $0.placeholder = "Search for a character..."
        $0.isTranslucent = true
        $0.searchTextField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        $0.searchBarStyle = UISearchBar.Style.minimal
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UISearchBar())
    
    private let charactersTitleLabel: UILabel = {
        $0.text = "Characters"
        $0.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = #colorLiteral(red: 0.2179532051, green: 0.2036896348, blue: 0.1906547546, alpha: 1)
        return $0
    }(UILabel())
    
    private let tableView: UITableView = {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.backgroundColor = #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
        $0.tableFooterView = UIView()
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.estimatedRowHeight = UITableView.automaticDimension
        return $0
    }(UITableView())
    
    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        setupTitle()
        setupSearchBar()
        setupCharactersTitle()
        setupTableView()
        setupObservers()
        viewModel.getCharacters()
    }
    
    init(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Some stuff happened")
    }
    
    // MARK: Setup
    func setupTitle() {
        view.addSubview(titleLabel)
        
        let marginTop = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 48)
        let marginLeft = NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant:24)
        let marginRight = NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant:-24)
        
        NSLayoutConstraint.activate([marginTop, marginLeft, marginRight])
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        
        let marginTop = NSLayoutConstraint(item: searchBar, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 16)
        let marginLeft = NSLayoutConstraint(item: searchBar, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant:16)
        let marginRight = NSLayoutConstraint(item: searchBar, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant:-16)
        
        let height = NSLayoutConstraint(item: searchBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 49)
        
        NSLayoutConstraint.activate([marginTop, marginLeft, marginRight, height])
    }
    
    func setupCharactersTitle() {
        view.addSubview(charactersTitleLabel)
        
        let marginTop = NSLayoutConstraint(item: charactersTitleLabel, attribute: .top, relatedBy: .equal, toItem: searchBar, attribute: .bottom, multiplier: 1.0, constant: 16)
        let marginLeft = NSLayoutConstraint(item: charactersTitleLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant:24)
        let marginRight = NSLayoutConstraint(item: charactersTitleLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant:-24)
        
        NSLayoutConstraint.activate([marginTop, marginLeft, marginRight])
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        let marginTop = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: charactersTitleLabel, attribute: .bottom, multiplier: 1.0, constant: 8)
        let marginLeft = NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0)
        let marginRight = NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant:0)
        let marginBottom = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([marginTop, marginLeft, marginRight, marginBottom])
    }
    
    private func setupObservers() {
        viewModel
            .error
            .observeOn(MainScheduler.init())
            .subscribe(onNext: { (error) in
                
            })
            .disposed(by: disposeBag)
        
        viewModel
            .charactersPublishSubject
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (characters) in
                self.characterList.append(contentsOf: characters)
                self.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Helpers
    func loadMoreData() {
        viewModel.getCharacters()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterTableViewCell") as? CharacterTableViewCell ??
            CharacterTableViewCell(style: .default, reuseIdentifier: "characterTableViewCell")
        cell.configureWith(CharacterTableViewCellViewModel(), character: characterList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterDetailViewController = CharacterDetailViewController(viewModel: CharacterDetailViewModel(), character: characterList[indexPath.row])
        present(characterDetailViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            loadMoreData()
        }
        
    }
}

extension CharacterListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
