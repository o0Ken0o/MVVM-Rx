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
    
    func getCoverImg() {
        SongsListAPIClient.shared.getImg(from: self.coverImage) { (isSuccessful, errorMsg, data) in
            if isSuccessful, let imageData = data {
                DispatchQueue.main.async { [unowned self] in
                    self.coverImgData.value = imageData
                }
            }
        }
    }
}
