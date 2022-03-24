//
//  CharacterListingProtocols.swift
//  characterDetail
//
//  Created by Anton Tropashko on 24.03.2022.
//

import Foundation

protocol CharactersPresenterProtocol
{
    func groom(accumulatedCharacters: [MarvelCharacter])
    func detailPresentable(atindex: Int)
}

protocol CharactersTableViewControllerProtocol
{
    func applySnapshot(figments: [MarvelCharacter], animatingDifferences: Bool)
}
