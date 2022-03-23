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
        let maxtablerows = 50
        loadCharacters(uptoindex: maxtablerows)
    }
    
    func loadCharacters(uptoindex: Int) -> Bool
    {
        return CharactersService.shared.loadCharacters(uptoindex: uptoindex, completion: {
            result in
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
        })
    }
}
