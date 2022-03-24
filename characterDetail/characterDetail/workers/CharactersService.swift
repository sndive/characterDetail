//
//  CharactersService.swift
//  characterDetail
//
//  Created by Anton Tropashko on 21.03.2022.
//
import Moya
import Foundation



class CharactersService: CharactersFetchProtocol
{
    static let shared = CharactersService()
    let provider = MoyaProvider<Marvel>()
    
    var accumulator: [MarvelCharacter] = []
    var characterOffset: Int = 0
    var limit: Int = 50
    var done = false
    private static let serial = OS_dispatch_queue_serial(label: "characters.loader")

    func loadCharacters(uptoindex: Int, completion: @escaping (Result<[MarvelCharacter], MoyaError>) -> Void) -> Bool
    {
        if done {
            completion(Result.success(accumulator))
            return false
        }
        CharactersService.serial.async {
            CharactersService.serial.suspend()
            _Concurrency.Task {
                let result = await CharactersService.shared.fetchCharacters(uptoindex: uptoindex)
                CharactersService.serial.resume()
                completion(result)
            }
        }
        return true
    }

    private func fetchCharacters(uptoindex: Int) async -> Result<[MarvelCharacter], MoyaError>
    {
        await withCheckedContinuation { continuation in
            NSLog("characters offset: \(characterOffset) begin")
            if done {
                NSLog("characters offset: \(characterOffset) done")
                continuation.resume(returning: Result.success(accumulator))
                return
            }
            if (uptoindex < accumulator.count) {
                NSLog("characters offset: \(characterOffset) enough")
                continuation.resume(returning: Result.success(accumulator))
                return
            }
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
                            if count == 0 {
                                self.done = true
                            } else {
                                self.characterOffset += count
                            }
                        }
                        continuation.resume(returning: Result.success(self.accumulator))
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
