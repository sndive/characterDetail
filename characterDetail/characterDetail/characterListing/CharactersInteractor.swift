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
    var worker: CharactersFetchProtocol = // to test optionality use FakeCharacterWorker()
        CharactersService.shared
    
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
        _ = groomPresentables(uptoindex: maxtablerows)
    }
    
    func groomPresentables(uptoindex: Int) -> Bool
    {
        return worker.loadCharacters(uptoindex: uptoindex, completion: {
            result in
            switch result
            {
            case .success:
                DispatchQueue.main.async
                {
                    [weak self] in
                    guard let self = self else {
                        assertionFailure()
                        return
                    }
                    self.presenter.groom(accumulatedCharacters: self.worker.accumulator)
                }
            case .failure(let error):
                router?.showError(error: error)
            }
        })
    }
    
    func detailCharacter(atindex: Int)
    {
        presenter.detailCharacter(atindex: atindex)
    }
}
