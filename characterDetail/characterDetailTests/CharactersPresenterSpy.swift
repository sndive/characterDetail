//
//  CharactersPresenterSpy.swift
//  characterDetailTests
//
//  Created by Anton Tropashko on 24.03.2022.
//

import Foundation

class CharactersPresenterSpy: CharactersPresenterProtocol
{
    var groomed = false
    
    weak var viewContoller: (CharactersTableViewControllerProtocol & NSObject)?
    
    init(viewContoller: (CharactersTableViewControllerProtocol & NSObject) )
    {
        self.viewContoller = viewContoller
    }

    func detailCharacter(atindex: Int) {
        
    }
    
    func groom(accumulatedCharacters: [MarvelCharacter])
    {
        let figments = accumulatedCharacters.filter
        {
            $0.id != nil
        }
        groomed = true
        viewContoller?.applySnapshot(figments: figments, animatingDifferences: true)
    }
}
