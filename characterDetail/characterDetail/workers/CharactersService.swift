//
//  CharactersService.swift
//  characterDetail
//
//  Created by Anton Tropashko on 21.03.2022.
//
import Moya
import Foundation

class CharactersService
{
    static let shared = CharactersService()
    let provider = MoyaProvider<Marvel>()
    var accumulator: [MarvelCharacter] = []
    
    func fetchCharacters() async -> Result<CharacterDataWrapper, MoyaError>
    {
        await withCheckedContinuation { continuation in
        
            provider.request(.characters) { [weak self] result in
                switch result {
                case .success(let response):
                    do {
                        let json = try response.mapJSON()
                        let decoder = JSONDecoder()
                        print(json)
                        if let jsonData = json as? Data {
                            let cdw = try decoder.decode(CharacterDataWrapper.self, from: jsonData)
                            if let results = cdw.data?.results {
                                self?.accumulator.append(contentsOf: results)
                            }
                            continuation.resume(returning: Result.success(cdw))
                        } else {
                            continuation.resume(returning: Result.failure(MoyaError.jsonMapping(response)))
                        }
                    } catch(let error) {
                        let result = MoyaError.underlying(error, nil)
//                        MoyaError.jsonMapping(response)
                        continuation.resume(returning: Result.failure(result))
                    }
                case .failure(let error):
                    let failure: Result<CharacterDataWrapper, MoyaError> = Result.failure(MoyaError.underlying(error, nil))
                    continuation.resume(returning: Result.failure(error))
                }
            }
        }
    }
//
//    func listCharacterDetails() -> Result<CharacterDataWrapper, Error>
//    {
    
    
//    }

}
