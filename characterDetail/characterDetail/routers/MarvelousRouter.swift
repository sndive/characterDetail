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
}
