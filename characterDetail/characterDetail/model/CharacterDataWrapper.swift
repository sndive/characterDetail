//
//  CharacterDataWrapper.swift
//  characterDetail
//
//  Created by Anton Tropashko on 21.03.2022.
//

import Foundation

struct CharacterDataWrapper: Decodable
{
    let code: String?
    let status: String?
    let data: CharacterDataContainer?
}
