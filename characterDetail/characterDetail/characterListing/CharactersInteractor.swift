//
//  CharactersInteractor.swift
//  characterDetail
//
//  Created by Anton Tropashko on 22.03.2022.
//

import Foundation

var router: MarvelousRouter?

class CharactersInteractor
{
    let presenter: CharactersPresenter
    private static let serial = OS_dispatch_queue_serial(label: "characters.loader")
    
    init?(viewContoller: CharactersTableViewController)
    {
        guard let nav = viewContoller.navigationController else {
            assertionFailure("fixme")
            return nil
        }
        presenter = CharactersPresenter(viewContoller: viewContoller)
        if router == nil {
            router = MarvelousRouter(navigationController: nav)
        }
        loadCharacters()
    }
    
    func loadCharacters()
    {
        CharactersInteractor.serial.async { Task {
            let result = await CharactersService.shared.fetchCharacters()
            switch result
            {
            case .success:
                DispatchQueue.main.async
                {
                    [weak self] in
                    self?.presenter.figments = CharactersService.shared.accumulator
                }
            case .failure(let error):
                router?.showError(error: error)
            }
        } }
    }
}
