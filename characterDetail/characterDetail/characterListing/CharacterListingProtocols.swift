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
    func detailCharacter(atindex: Int)
}

protocol CharactersTableViewControllerProtocol
{
    func applySnapshot(figments: [MarvelCharacter], animatingDifferences: Bool)
}

protocol MarvelousRouterProtocol
{
    func showError(error: Error)
    func initiate(forCharacter: MarvelCharacter?)
    func updateFor(character: MarvelCharacter?)
}
