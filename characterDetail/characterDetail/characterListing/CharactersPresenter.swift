//
//  CharactersPresenter.swift
//  characterDetail
//
//  Created by Anton Tropashko on 22.03.2022.
//

import Foundation

class CharactersPresenter: CharactersPresenterProtocol
{
    private(set) var figments: [MarvelCharacter] = [] {
        didSet {
            // thankfully we need no wrapper at the time cause the data is neat and tidy, sorted for us
            if oldValue.count != figments.count {
                viewContoller?.applySnapshot(figments: figments, animatingDifferences: true)
                router?.initiate(forCharacter: figments.first)
            }
        }
    }
    weak var viewContoller: (CharactersTableViewControllerProtocol & NSObject)?
    
    init(viewContoller: (CharactersTableViewControllerProtocol & NSObject) )
    {
        self.viewContoller = viewContoller
    }
    
    func detailCharacter(atindex: Int)
    {
        guard atindex < figments.count else {
            assertionFailure()
            return
        }
        let character = figments[atindex]
        router?.updateFor(character: character)
    }
    
    func groom(accumulatedCharacters: [MarvelCharacter])
    {
        figments = accumulatedCharacters.filter
        {
            $0.id != nil
        }
    }

}
