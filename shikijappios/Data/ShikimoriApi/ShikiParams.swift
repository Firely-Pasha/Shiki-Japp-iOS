//
//  ShikiParams.swift
//  shikijappios
//
//  Created by Pavel on 26.04.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import Foundation

struct AnimesParams: Encodable {
    var limit = 10
    var page = 1
    var status = ""
    var kind = ""
    var rating = ""
}
