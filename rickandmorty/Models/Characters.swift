//
//  Characters.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 26/11/20.
//

import Foundation
struct Characters: Decodable {
    let results: [Character]
    let info: Info
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String
    
    init(count: Int, pages: Int, next: String) {
        self.count = count
        self.pages = pages
        self.next = next
    }
}
