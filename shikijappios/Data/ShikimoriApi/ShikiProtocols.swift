//
//  ShikiProtocols.swift
//  shikijappios
//
//  Created by Pavel on 01.05.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import Foundation

protocol Title {
    var id: Int { get }
    var name: String { get }
    var score: String { get }
    var image: ShikiImageModel { get }
    var aired_on: String? { get }
    var released_on: String? { get }
    var status: TitleStatus { get}
}

protocol Anime: Title, Encodable {
    var kind: AnimeKind { get }
    var episodes: Int { get }
    var episodes_aired: Int? { get }
}

protocol TitleInfo: Title {
    var description: String? { get }
}

protocol AnimeInfo: Anime,TitleInfo {
    var duration: Int? { get }
}

protocol ShikiImage: Codable {
    var original: String { get }
    var preview: String { get }
    var x96: String { get }
    var x48: String { get }
}
