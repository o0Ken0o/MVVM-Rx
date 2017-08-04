//
//  SongsListViewController.swift
//  MVVMRx
//
//  Created by Kam Hei Siu on 3/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SongsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var songsListViewModel: SongsListViewModel!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: SongCell.CellIdentifier)
        
        songsListViewModel.list.asObservable()
            .bind(to: tableView
                .rx
                .items(cellIdentifier: SongCell.CellIdentifier, cellType: SongCell.self)) {
                    row, song, cell in
                  cell.configureCell(songViewModel: song)
            }
            .addDisposableTo(disposeBag)
    }
}

extension SongsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return songsListViewModel.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
