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
    var characterOffset: Int = 0
    var limit: Int = 50
    
    func fetchCharacters() async -> Result<CharacterDataWrapper, MoyaError>
    {
        await withCheckedContinuation { continuation in
            NSLog("characters offset: \(characterOffset) begin")

            provider.request(.characters(characterOffset, limit)) { result in
                switch result {
                case .success(let response):
                    NSLog("characters offset: \(self.characterOffset) s end")
                    do {
                        #if DEBUG
//                        let json = try response.mapJSON()
//                        print(json)
                        #endif
                        let cdw = try response.map(CharacterDataWrapper.self)
                        
                        if let results = cdw.data?.results {
                            self.accumulator.append(contentsOf: results)
                            let count = cdw.data?.count ?? results.count
                            self.characterOffset += count
                        }
                        continuation.resume(returning: Result.success(cdw))
                    } catch(let error) {
                        NSLog("characters offset: \(self.characterOffset) fend")
                        let result = MoyaError.underlying(error, nil)
//                        MoyaError.jsonMapping(response)
                        continuation.resume(returning: Result.failure(result))
                    }
                case .failure(let error):
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
