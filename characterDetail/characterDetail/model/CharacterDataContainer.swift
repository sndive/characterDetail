//
//  CharacterDataContainer.swift
//  characterDetail
//
//  Created by Anton Tropashko on 21.03.2022.
//

import Foundation

struct CharacterDataContainer: Decodable
{
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [MarvelCharacter]?
}
