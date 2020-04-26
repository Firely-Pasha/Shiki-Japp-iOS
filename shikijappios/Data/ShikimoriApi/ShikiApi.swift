//
//  Shikimori.swift
//  shikijappios
//
//  Created by Pavel on 25.04.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import Foundation
import Alamofire

let shikimoriApi = ShikimoriApi()

class ShikimoriApi {
    static let siteUrl = "https://shikimori.one"
    static let apiUrl = ShikimoriApi.siteUrl + "/api"
    static let apiV1Url = ShikimoriApi.apiUrl + ""
    static let apiV2Url = ShikimoriApi.apiUrl + "/v2"
    
    private let decoder = JSONDecoder()
    
    private let headers: HTTPHeaders = [
        "Accept": "application/json"
    ]
    
    static func getImageUrl(path: String) -> String {
        return ShikimoriApi.siteUrl + path
    }
    
    func getAnimes(params: AnimesParams, completion: @escaping ([AnimeModel]) -> ()) {
        AF.request(ShikimoriApi.apiUrl + "/animes", parameters: params, encoder: URLEncodedFormParameterEncoder(destination: .methodDependent), headers: headers).validate().responseJSON { response in
            let animes = try! self.decoder.decode([AnimeModel].self, from: response.data!)
            completion(animes)
        }
    }
    
    func getAnime(animeId: Int, completion: @escaping (AnimeInfoModel) -> ()) {
        AF.request(ShikimoriApi.apiUrl + "/animes/\(animeId)", headers: headers).validate().responseJSON { response in
            let animes = try! self.decoder.decode(AnimeInfoModel.self, from: response.data!)
            completion(animes)
        }
    }
}
