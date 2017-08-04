//
//  SongsListViewModelFromSongs.swift
//  MVVMRx
//
//  Created by Kam Hei Siu on 4/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import Foundation
import RxSwift

class SongsListViewModelFromSongs: SongsListViewModel {
    
    let disposeBag = DisposeBag()
    
    private var songs: [Song]
    var list: Variable<[SongViewModel]>
    var noOfSections: Variable<Int>
    var noOfRows: Variable<Int>
    var rowHeight: CGFloat
    
    init(songs: [Song]) {
        self.songs = songs
        self.list = Variable(self.songs.map{ SongViewModelFromSong(song: $0) })
        self.noOfSections = Variable(1)
        self.noOfRows = Variable(self.list.value.count)
        self.rowHeight = 150
        
        
        self.list.asObservable()
            .bind { (songViewModelsList) in
                self.noOfSections.value = 1
                self.noOfRows.value = songViewModelsList.count
            }
            .addDisposableTo(disposeBag)
        
        getSongs()
    }
    
    func getSongs() {
        SongsListAPIClient.shared.getSongsList(completion: didGetSongs)
    }
    
    func didGetSongs(isSuccessful: Bool, errorMsg: String?, list: [Song]?) {
        if isSuccessful {
            songs = list ?? []
            self.list.value = self.songs.map{ SongViewModelFromSong(song: $0) }
        }
    }
}
