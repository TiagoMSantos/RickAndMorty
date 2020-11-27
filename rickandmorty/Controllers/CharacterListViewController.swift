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
        $0.text = "Characters"
        $0.font = .boldSystemFont(ofSize: 24)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let tableView: UITableView = {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .systemGray5
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
        setupTableView()
        setupBindings()
        viewModel.getCharacters()
        view.backgroundColor = .white
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
        
        let marginTop = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 24)
        let marginLeft = NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant:24)
        let marginRight = NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant:-24)
        
        NSLayoutConstraint.activate([marginTop, marginLeft, marginRight])
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        let marginTop = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 24)
        let marginLeft = NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0)
        let marginRight = NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant:0)
        let marginBottom = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([marginTop, marginLeft, marginRight, marginBottom])
    }
    
    private func setupBindings() {
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
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterTableViewCell") as? CharacterTableViewCell ??
            CharacterTableViewCell(style: .default, reuseIdentifier: "characterTableViewCell")
        
        cell.nameLabel.text = characterList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
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
