//
//  CharacterDetailViewModel.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 25/11/20.
//

import Foundation
import RxSwift
import RxCocoa

final class CharacterDetailViewModel: BaseViewModel {
    
    // MARK: Variables
    private let repository: NetworkManager = NetworkManager()
    public let imagePublishSubject : PublishSubject<UIImage> = PublishSubject()
    public let firstEpisodeNamePublishSubject : PublishSubject<String?> = PublishSubject()
    
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
    
    func getEpisode(url: String) {
        repository.getEpisode(url: url) { (episode, error) in
            self.firstEpisodeNamePublishSubject.onNext(episode?.name)
        }
    }
    
}
