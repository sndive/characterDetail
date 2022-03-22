//
//  CharactersPresenter.swift
//  characterDetail
//
//  Created by Anton Tropashko on 22.03.2022.
//

import Foundation

class CharactersPresenter
{
    var figments: [MarvelCharacter] = []
    weak var viewContoller: CharactersTableViewController?
    
    init(viewContoller: CharactersTableViewController)
    {
        self.viewContoller = viewContoller
    }
}
