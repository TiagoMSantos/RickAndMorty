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
