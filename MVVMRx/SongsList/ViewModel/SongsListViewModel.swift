//
//  SongsListViewModel.swift
//  MVVMRx
//
//  Created by Kam Hei Siu on 4/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import Foundation
import RxSwift

protocol SongsListViewModel {
    var list: Variable<[SongViewModel]> { get }
    var noOfSections: Variable<Int> { get }
    var noOfRows: Variable<Int> { get }
    var rowHeight: CGFloat { get }
}
