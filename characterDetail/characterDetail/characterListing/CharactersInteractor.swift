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
        Task {
            await loadCharacters()
        }
    }
    
    func loadCharacters() async
    {
        let result = await CharactersService.shared.fetchCharacters()
        switch result
        {
        case .success:
            presenter.figments = CharactersService.shared.accumulator
        case .failure(let error):
            router?.showError(error: error)
        }
    }
}
