//
//  WorkerProtocols.swift
//  characterDetail
//
//  Created by Anton Tropashko on 24.03.2022.
//
import Moya
import Foundation

protocol CharactersFetchProtocol
{
    var accumulator: [MarvelCharacter] { get }
    func loadCharacters(uptoindex: Int, completion: @escaping (Result<[MarvelCharacter], MoyaError>) -> Void) -> Bool
}
