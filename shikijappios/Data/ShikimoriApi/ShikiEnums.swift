//
//  ShikiEnumss.swift
//  shikijappios
//
//  Created by Pavel on 01.05.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import Foundation

enum TitleStatus: String, Codable {
    case anons
    case ongoing
    case released
    
    func getString() -> String {
        switch self {
        case .anons:
            return "Anons"
        case .ongoing:
            return "Ongoing"
        case .released:
            return "Released"
        default:
            return "Unknown"
        }
    }
}

enum AnimeKind: String, Codable {
    case tv
    case movie
    case special
    case ona
    case ova
    case music
    
    func getString() -> String {
        switch self {
        case .tv:
            return "TV Series"
        case .movie:
            return "Movie"
        default:
            return "Unknown"
        }
    }
}

enum AnimeRating: String, Codable {
    case g
    case pg
    case pg_13
    case r
    case r_plus
    case rx
}
