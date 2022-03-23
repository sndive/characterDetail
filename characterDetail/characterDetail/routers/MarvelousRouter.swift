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
    weak var detail: CharacterDetailsViewController?
    
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
        if let detail = detail, detail.isOnScreen {
            updateFor(character: character)
        } else {
            // non plus devices
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "characterDetail") as? CharacterDetailsViewController else {
                assertionFailure()
                return
            }
            //
            //            let vc = CharacterDetailsViewController(nibName: "CharacterDetailsViewController", bundle: nil)
            vc.character = character
            self.navigationController.pushViewController(vc, animated: true)
        }
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
