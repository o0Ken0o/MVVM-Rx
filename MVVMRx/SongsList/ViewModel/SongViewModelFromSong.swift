//
//  SongViewModelFromSong.swift
//  MVVMRx
//
//  Created by Kam Hei Siu on 3/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import Foundation
import RxSwift

class SongViewModelFromSong: SongViewModel {
    let song: Song

    let coverImage: String
    var coverImgData: Variable<Data?>
    let songName: String
    let artistName: String
    let releaseDate: String
    
    init(song: Song) {
        self.song = song
        self.coverImage = song.coverImg
        self.coverImgData = Variable<Data?>(nil)
        self.songName = song.songName
        self.artistName = song.artistName
        self.releaseDate = SongViewModelFromSong.getString(from: song.releaseDate)
    }
    
    private static func getString(from date: Date?) -> String {
        guard let date = date else { return "---" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    func getCoverImg(from urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [unowned self] (data, response, error) in
            if let _ = error {
                return
            } else {
                if let res = response as? HTTPURLResponse, res.statusCode / 200 == 2, let imageData = data {
                    DispatchQueue.main.async {
                        self.coverImgData.value = imageData
                    }
                }
            }
            
        }
        
        task.resume()
    }
}
