//
//  CharactersInteractor.swift
//  characterDetail
//
//  Created by Anton Tropashko on 22.03.2022.
//

import Foundation

class CharactersInteractor
{
    var presenter: CharactersPresenterProtocol
    // in case force unwrap bombs check dependency injection: this is configured by the user code
    var worker: CharactersFetchProtocol! // =  to test optionality use FakeCharacterWorker()
//        CharactersService.shared
    {
        didSet {
            let maxtablerows = 50
            _ = fetchCharacters(uptoindex: maxtablerows)
        }
    }
    
    init?(presenter: CharactersPresenterProtocol)
    {
        self.presenter = presenter
    }

    func fetchCharacters(uptoindex: Int) -> Bool
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
