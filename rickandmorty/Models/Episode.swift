//
//  Episode.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 01/12/20.
//

import Foundation
struct Episode: Decodable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    
    init(id: Int, name: String, air_date: String, episode: String, characters: [String], url: String) {
        self.id = id
        self.name = name
        self.air_date = air_date
        self.episode = episode
        self.characters = characters
        self.url = url
    }
}
