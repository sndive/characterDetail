//
//  CharactersPresenter.swift
//  characterDetail
//
//  Created by Anton Tropashko on 22.03.2022.
//

import Foundation

class CharactersPresenter
{
    var figments: [MarvelCharacter] = [] {
        didSet {
            // thankfully we need no wrapper at the time cause the data is neat and tidy, sorted for us
            if oldValue.count != figments.count {
                viewContoller?.applySnapshot(figments: figments, animatingDifferences: true)
            }
        }
    }
    weak var viewContoller: CharactersTableViewController?
    
    init(viewContoller: CharactersTableViewController)
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
        router?.detail(character: character)

    }

}
