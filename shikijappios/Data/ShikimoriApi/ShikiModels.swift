//
//  ShikimoriModels.swift
//  shikijappios
//
//  Created by Pavel on 25.04.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import Foundation

struct AnimeModel: Anime, Codable {
    public var id: Int
    var name: String
    var score: String
    var image: ShikiImageModel
    var aired_on: String?
    var released_on: String?
    var status: TitleStatus
    
    var kind: AnimeKind
    var episodes: Int
    var episodes_aired: Int?
}

struct AnimeInfoModel: AnimeInfo, Codable {    
    public var id: Int
    var name: String
    var score: String
    var image: ShikiImageModel
    var aired_on: String?
    var released_on: String?
    var status: TitleStatus
    
    var kind: AnimeKind
    var episodes: Int
    var episodes_aired: Int?
    
    var duration: Int?
    
    var description: String?
}

struct ShikiImageModel: ShikiImage, Codable {
    var original: String
    var preview: String
    var x96: String
    var x48: String
}
