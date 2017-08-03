//
//  SongViewModel.swift
//  MVVMRx
//
//  Created by Kam Hei Siu on 3/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import Foundation
import RxSwift

protocol SongViewModel {
    var coverImage: String { get }
    var coverImgData: Variable<Data?> { get }
    var songName: String { get }
    var artistName: String { get }
    var releaseDate: String { get }
}
