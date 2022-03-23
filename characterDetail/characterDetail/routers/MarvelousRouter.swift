//
//  MarvelousRouter.swift
//  characterDetail
//
//  Created by Anton Tropashko on 22.03.2022.
//

import Foundation
import UIKit

class MarvelousRouter
{
    let navigationController: UINavigationController
    var detail: CharacterDetailsViewController?
    
    init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
    }
    
    func showError(error: Error)
    {
        DispatchQueue.main.async
        {
            let evc = ErrorViewController()
            evc.errorText = error.localizedDescription
            self.navigationController.pushViewController(evc, animated: true)
        }
    }
    
    func detail(character: MarvelCharacter)
    {
        updateFor(character: character)
//
//        let vc = CharacterDetailsViewController(nibName: "CharacterDetailsViewController", bundle: nil)
//        vc.character = character
//        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func setDetail(vc: CharacterDetailsViewController)
    {
        detail = vc
    }
    
    func updateFor(character: MarvelCharacter?)
    {
        detail?.character = character
    }
}
