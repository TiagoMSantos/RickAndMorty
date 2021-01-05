//
//  Episodes.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 01/12/20.
//

import Foundation
struct Episodes: Decodable {
    let results: [Episode]
    let info: Info
}
