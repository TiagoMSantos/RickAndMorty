//
//  Character.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 25/11/20.
//

import Foundation
struct Character : Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin?
    let location: Origin?
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    init(id: Int, name: String, status: String, species: String, type: String, gender: String, origin: Origin?, location: Origin?, image: String, episode: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
        self.origin = origin
        self.location = location
    }
}

struct Origin: Decodable {
    let name: String
    let url: String
}

struct InfoModel: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let previous: String?
}

struct Results: Decodable {
    let info: InfoModel
    let results: [Character]
}
