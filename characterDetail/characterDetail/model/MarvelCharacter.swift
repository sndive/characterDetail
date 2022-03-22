//
//  Character.swift
//  characterDetail
//
//  Created by Anton Tropashko on 21.03.2022.
//

import Foundation

struct MarvelCharacter: Decodable
{
    let id: Int64? // (int, optional): The unique ID of the character resource.,
    let name: String? // (string, optional): The name of the character.,
    let description: String? //(string, optional): A short bio or description of the character.,
//    modified (Date, optional): The date the resource was most recently modified.,
//    resourceURI (string, optional): The canonical URL identifier for this resource.,
//    urls (Array[Url], optional): A set of public web site URLs for the resource.,
    let thumbnail: ThumbnailImage? //The representative image for this character.,
//    comics (ComicList, optional): A resource list containing comics which feature this character.,
//    stories (StoryList, optional): A resource list of stories in which this character appears.,
//    events (EventList, optional): A resource list of events in which this character appears.,
//    series (SeriesList, optional): A resource list of series in which this character appears.
}
