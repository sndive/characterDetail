//
//  MarvelCharacter+Hashable.swift
//  characterDetail
//
//  Created by Anton Tropashko on 22.03.2022.
//

import Foundation

extension MarvelCharacter: Hashable
{
    static func == (lhs: MarvelCharacter, rhs: MarvelCharacter) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
}
