//
//  Song.swift
//  MVVMRx
//
//  Created by Kam Hei Siu on 3/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Song {
    let artistId: Int
    let artistName: String
    let artistUrl: String
    let coverImg: String
    let copyright: String
    let songId: Int
    let songKind: String
    let songName: String
    let genreName: String
    let releaseDate: Date? // format eg 2017-08-01T00:00:00Z
    
    init(json: JSON) {
        artistId = json["artistId"].intValue
        artistName = json["artistName"].stringValue
        artistUrl = json["artistUrl"].stringValue
        coverImg = json["artworkUrl100"].stringValue
        copyright = json["copyright"].stringValue
        songId = json["id"].intValue
        songKind = json["kind"].stringValue
        songName = json["name"].stringValue
        genreName = json["primaryGenreName"].stringValue
        releaseDate = Song.formatDate(dateStr: json["releaseDate"].stringValue)
    }
    
    private static func formatDate(dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: dateStr)
    }
}
