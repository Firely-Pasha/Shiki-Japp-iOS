//
//  ShikiEnumss.swift
//  shikijappios
//
//  Created by Pavel on 01.05.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import Foundation

protocol ShikiEnum: Codable {    
    func getCode() -> String
}

enum TitleStatus: String, ShikiEnum {
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
    
    func getCode() -> String {
        return self.rawValue
    }
}

enum AnimeKind: String, ShikiEnum {
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
    
    func getCode() -> String {
        return self.rawValue
    }
}

enum AnimeRating: String, ShikiEnum {
    case g
    case pg
    case pg_13
    case r
    case r_plus
    case rx
    
    func getCode() -> String {
        return self.rawValue
    }
}
