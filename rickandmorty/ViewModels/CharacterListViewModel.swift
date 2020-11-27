//
//  CharacterListViewModel.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 25/11/20.
//

import Foundation
import RxSwift
import RxCocoa

final class CharacterListViewModel: BaseViewModel {
    var nextUrl: String = "https://rickandmortyapi.com/api/character/"
    
    // MARK: Variables
    public let charactersPublishSubject : PublishSubject<[Character]> = PublishSubject()
    private let repository: NetworkManager = NetworkManager()
    
    // MARK: Handlers
    private func handleCharactersListServiceResponse(response: Characters) {
        nextUrl = response.info.next
        self.charactersPublishSubject.onNext(response.results)
    }
    
    // MARK: Services
    func getCharacters() {
        repository.getCharactersList(url: nextUrl, completion: { (characters, error) in
            self.handleCharactersListServiceResponse(response: characters!)
        })
    }
    
}
