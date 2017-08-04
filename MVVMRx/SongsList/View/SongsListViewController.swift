//
//  SongsListViewController.swift
//  MVVMRx
//
//  Created by Kam Hei Siu on 3/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import UIKit
import RxSwift

class SongsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var songsListViewModel: SongsListViewModel!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: SongCell.CellIdentifier)
        
        songsListViewModel.list.asObservable()
            .bind { [unowned self] (viewModels) in
                self.tableView.reloadData()
            }
            .addDisposableTo(disposeBag)
    }
}

extension SongsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return songsListViewModel.noOfSections.value
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsListViewModel.noOfRows.value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let songViewModel = songsListViewModel.list.value[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.CellIdentifier, for: indexPath) as? SongCell {
            cell.configureCell(songViewModel: songViewModel)
            return cell
        }
        
        let cell = SongCell()
        cell.configureCell(songViewModel: songViewModel)
        
        return cell
    }
}

extension SongsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return songsListViewModel.rowHeight
    }
}
