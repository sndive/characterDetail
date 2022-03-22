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
        let maxtablerows = 50
        loadCharacters(uptoindex: maxtablerows)
    }
    
    func loadCharacters(uptoindex: Int)
    {
        CharactersInteractor.serial.async {
            CharactersInteractor.serial.suspend()
            Task {
                let result = await CharactersService.shared.fetchCharacters(uptoindex: uptoindex)
                CharactersInteractor.serial.resume()
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
            }
        }
    }
}
