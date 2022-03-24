//
//  TableViewControllerSpy.swift
//  characterDetailTests
//
//  Created by Anton Tropashko on 24.03.2022.
//

import Foundation

class TableViewControllerSpy: NSObject, CharactersTableViewControllerProtocol
{
    var applySnapshotInvoked = false
    
    func applySnapshot(figments: [MarvelCharacter], animatingDifferences: Bool)
    {
        applySnapshotInvoked = true
    }
}
