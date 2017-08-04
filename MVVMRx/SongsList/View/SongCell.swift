//
//  SongCell.swift
//  MVVMRx
//
//  Created by Kam Hei Siu on 3/8/2017.
//  Copyright © 2017 Kam Hei Siu. All rights reserved.
//

import UIKit
import RxSwift

class SongCell: UITableViewCell {
    
    @IBOutlet weak var coverImgView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    static let CellIdentifier = "SongCell"
    
    var viewModel: SongViewModel!
    var getImgObservable: Disposable!
    
    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(songViewModel: SongViewModel) {
        viewModel = songViewModel
        
        coverImgView.image = UIImage(named: "default")
        coverImgView.contentMode = .scaleAspectFit
        songNameLabel.text = songViewModel.songName
        artistNameLabel.text = songViewModel.artistName
        releaseDateLabel.text = songViewModel.releaseDate
        
        getImgObservable = viewModel.coverImgData.asObservable()
            .bind(onNext: { [unowned self] (data) in
                if let data = data {
                    self.coverImgView.image = UIImage(data: data)
                    self.setNeedsLayout()
                }
            })
        getImgObservable.addDisposableTo(disposeBag)
        viewModel.getCoverImg()
    }
    
    override func prepareForReuse() {
        getImgObservable.dispose()
        super.prepareForReuse()
    }
}
