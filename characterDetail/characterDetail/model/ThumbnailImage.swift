//
//  ThumbnailImage.swift
//  characterDetail
//
//  Created by Anton Tropashko on 21.03.2022.
//

import Foundation

struct ThumbnailImage: Decodable
{
    enum CodingKeys: String, CodingKey {
        case path
        case fileextension = "extension"
    }
    let path: String? // (string, optional): The directory path of to the image.,
    let fileextension: String? // (string, optional): The file extension for the image.
}
