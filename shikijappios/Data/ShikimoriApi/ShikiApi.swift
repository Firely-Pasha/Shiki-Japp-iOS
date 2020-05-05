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
        var url = "/animes?";
        url += "&status=" + params.status
        url += "&kind=" + params.kind
        url += "&rating=" + params.rating
        if (params.limit != 0) {
            url += "&limit=\(params.limit)"
        }
        AF.request(ShikimoriApi.apiUrl + url, headers: headers).validate().responseJSON { response in
            print(response.request?.url?.absoluteString)
            print(String(data: response.data!, encoding: .utf8))

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
