//
//  TrackCell.swift
//  ITunesMusicParsingJSON
//
//  Created by Igor on 26.03.2022.
//

import UIKit

class TrackCell: UITableViewCell {
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var trackImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // для заполнения ячейки данными
    func setupCell(track: Track?) {
        self.trackName.text = track?.trackName
        self.collectionName.text = track?.collectionName ?? "no collection"
        self.artistName.text = track?.artistName
        
        let completeLink = track?.artworkUrl60
        self.trackImage.downloaded(from: completeLink!)
        
        self.trackName.adjustsFontSizeToFitWidth = true
        self.collectionName.adjustsFontSizeToFitWidth = true
        self.artistName.adjustsFontSizeToFitWidth = true
        self.trackName.numberOfLines = 2
        self.collectionName.numberOfLines = 2
        self.artistName.numberOfLines = 2
        
        // круглость
        self.clipsToBounds = true
        self.trackImage.layer.cornerRadius = self.trackImage.frame.height / 2
        self.trackImage.contentMode = .scaleAspectFill
    }
    
    // для переиспользования
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.trackImage.image = nil
    }
    
}
