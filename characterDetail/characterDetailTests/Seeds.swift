//
//  Seeds.swift
//  characterDetailTests
//
//  Created by Anton Tropashko on 24.03.2022.
//

import Foundation

var consequitive: Int64 = 0

struct Seeds
{
    static var marvelCharacter: MarvelCharacter
    {
        let id: Int64? = arc4random() % 2 == 0 ? nil : consequitive
        consequitive += 1
        let name: String? = arc4random() % 2 == 0 ? nil : "fixed"
        let thumbnailImage: ThumbnailImage? = arc4random() % 2 == 0 ? nil : ThumbnailImage(path: "https://random.com", fileextension: "jpeg")
        let result = MarvelCharacter(id: id, name: name, description: "unused", thumbnail: thumbnailImage)
        return result
    }
}
