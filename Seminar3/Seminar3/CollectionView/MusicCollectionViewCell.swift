//
//  MusicCollectionViewCell.swift
//  Seminar3
//
//  Created by taehy.k on 2022/04/25.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MusicCollectionViewCell"
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // 데이터 세팅 함수
    func setData(albumData : AlbumDataModel) {
        albumImageView.image = UIImage(named: albumData.albumImageName)
        albumTitleLabel.text = albumData.albumTitle
        singerLabel.text = albumData.albumSinger
    }
}
