//
//  CharacterTableViewCellViewModel.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 30/11/20.
//

import Foundation
import RxSwift
import RxCocoa

class CharacterTableViewCellViewModel: BaseViewModel {
    // MARK: Variables
    private let repository: NetworkManager = NetworkManager()
    public let imagePublishSubject : PublishSubject<UIImage> = PublishSubject()
    
    // MARK: Services
    func getImage(url: String) {
        repository.fetchImage(from: url) { (imageData) in
            if let data = imageData {
                DispatchQueue.main.async {
                    self.imagePublishSubject.onNext(UIImage(data: data)!)
                }
            } else {
                print("Error loading image");
            }
        }
    }
}
