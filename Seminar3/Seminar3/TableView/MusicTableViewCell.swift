//
//  MusicTableViewCell.swift
//  Seminar3
//
//  Created by taehy.k on 2022/04/25.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    // Cell을 구분하기 위한 Identifier
    static let identifier = "MusicTableViewCell"
    
    @IBOutlet weak var albumCoverImage: UIImageView!
    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var musicDescriptionLabel: UILabel!

    // 초기화 해주는 작업을 해당 메서드 안에서 진행
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // 각 Cell 별로 다른 정보가 표시되어야 하므로, 값을 넣어주는 함수를 생성
    func setData(_ musicData: MusicDataModel) {
        albumCoverImage.image = musicData.albumImage
        musicTitleLabel.text = musicData.musicTitle
        musicDescriptionLabel.text = musicData.description
    }
}
