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
    weak var split: UISplitViewController?
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
    
    func setDetail(vc: CharacterDetailsViewController,
                   split: UISplitViewController)
    {
        detail = vc
        self.split = split
    }

    var initiated = false
    func initiate(forCharacter: MarvelCharacter?)
    {
        if initiated {
            return
        }
        updateFor(character: forCharacter)
        initiated = true
    }
    
    func updateFor(character: MarvelCharacter?)
    {
        guard let split = split else {
            assertionFailure()
            return
        }
        if let detail = detail, detail.isOnScreen {
            detail.character = character
            return
        }
        if split.isCollapsed ||
            detail == nil {
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "characterDetail") as? CharacterDetailsViewController else {
                assertionFailure()
                return
            }
            //
            //            let vc = CharacterDetailsViewController(nibName: "CharacterDetailsViewController", bundle: nil)
            vc.character = character
            let nav = UINavigationController(rootViewController: vc)
            split.showDetailViewController(nav, sender: self)
            return
        }
    }
}
