//
//  FakeCharacterWorker.swift
//  characterDetailTests
//
//  Created by Anton Tropashko on 24.03.2022.
//
import Moya
import Foundation

class FakeCharacterWorker: CharactersFetchProtocol
{
    var done = false
    var accumulator: [MarvelCharacter] = []
    
    func loadCharacters(uptoindex: Int, completion: @escaping (Result<[MarvelCharacter], MoyaError>) -> Void) -> Bool
    {
        while accumulator.count <= uptoindex {
            accumulator.append(Seeds.marvelCharacter)
        }
        completion(Result.success(self.accumulator))
        return !done
    }

}
