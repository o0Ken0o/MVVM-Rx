//
//  SongCell.swift
//  MVVMRx
//
//  Created by Kam Hei Siu on 3/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    
    @IBOutlet weak var coverImgView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    static let CellIdentifier = "SongCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(songViewModel: SongViewModel) {
        coverImgView.image = UIImage(named: "default")
        coverImgView.contentMode = .scaleAspectFit
        songNameLabel.text = songViewModel.songName
        artistNameLabel.text = songViewModel.artistName
        releaseDateLabel.text = songViewModel.releaseDate
    }
}
