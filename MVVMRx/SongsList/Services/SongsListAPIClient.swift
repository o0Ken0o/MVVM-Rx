//
//  SongsListAPIClient.swift
//  MVVMRx
//
//  Created by Kam Hei Siu on 3/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SongsListAPIClient {
    static let shared = SongsListAPIClient()
    
    let songsEndpt = "https://rss.itunes.apple.com/api/v1/hk/apple-music/hot-tracks/25/explicit/json"
    
    private init() {}
    
    func getSongsList(completion: @escaping (Bool, String?, [Song]?) -> ()) {
        Alamofire.request(songsEndpt).validate().responseJSON { (response) in
            switch response.result {
                
            case .success(let value):
                let feed = JSON(value)["feed"].dictionaryValue
                let results = JSON(feed)["results"].arrayValue
                let songs = results.map{ Song(json: $0) }
                completion(true, nil, songs)
                
            case .failure(let error):
                completion(false, error.localizedDescription, nil)
            }
        }
    }
}
