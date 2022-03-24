//
//  MarvelousRouterSpy.swift
//  characterDetailTests
//
//  Created by Anton Tropashko on 24.03.2022.
//

import Foundation

class MarvelousRouterSpy: MarvelousRouterProtocol
{
    var character: MarvelCharacter?
    
    func showError(error: Error)
    {
        
    }
    func initiate(forCharacter: MarvelCharacter?)
    {
    }
    
    func updateFor(character: MarvelCharacter?) {
        self.character = character
    }
    

}
