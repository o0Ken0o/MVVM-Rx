//
//  SongsListViewController.swift
//  MVVMRx
//
//  Created by Kam Hei Siu on 3/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import UIKit

class SongsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var songsList: [SongViewModel] = [] {
        didSet {
            reloadTable()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: SongCell.CellIdentifier)
        
        getSongs()
    }
    
    func getSongs() {
        SongsListAPIClient.shared.getSongsList(completion: didGetSongs)
    }
    
    func didGetSongs(isSuccessful: Bool, errorMsg: String?, list: [SongViewModel]?) {
        if isSuccessful {
            songsList = list!
        }
    }
    
    func reloadTable() {
        if !isViewLoaded {
            return
        }
        
        tableView.reloadData()
    }
}

extension SongsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let songViewModel = songsList[indexPath.row]
        
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
        return 120
    }
}
