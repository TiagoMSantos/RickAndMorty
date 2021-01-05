//
//  Info.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 01/12/20.
//

import Foundation

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
