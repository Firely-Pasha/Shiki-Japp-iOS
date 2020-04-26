//
//  ShikimoriModels.swift
//  shikijappios
//
//  Created by Pavel on 25.04.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import Foundation

class AnimeModel: Codable, Identifiable {
    var id: Int
    var name: String
    var score: String
    var image: ImageModel
}

struct AnimeInfoModel: Equatable, Codable, Identifiable {
    static func == (lhs: AnimeInfoModel, rhs: AnimeInfoModel) -> Bool {
        return true
    }
    
    var id: Int
    var name: String
    var score: String
    var image: ImageModel
}

struct ImageModel: Codable {
    var original: String
    var preview: String
    var x96: String
    var x48: String
}
