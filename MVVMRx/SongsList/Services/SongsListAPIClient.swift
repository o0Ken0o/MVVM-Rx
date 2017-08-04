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
    
    func getImg(from urlStr: String, completion: @escaping (Bool, String?, Data?) -> ()) {
        guard let url = URL(string: urlStr) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(false, error.localizedDescription, nil)
            } else {
                if let res = response as? HTTPURLResponse, res.statusCode / 100 == 2, let imageData = data {
                    completion(true, nil, imageData)
                } else {
                    completion(false, "response not 2xx", nil)
                }
            }
            
        }
        
        task.resume()
    }
}
