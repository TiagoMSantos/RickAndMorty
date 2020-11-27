//
//  BaseViewModel.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 25/11/20.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    public enum HomeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<HomeError> = PublishSubject()
    private let disposable = DisposeBag()
}
