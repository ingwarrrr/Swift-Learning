//
//  CustomCollectionViewCell.swift
//  DotaHeroesCV
//
//  Created by Igor on 13.03.2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // для заполнения ячейки данными
    func setupCell(hero: Hero) {
        self.nameLabel.text = hero.localized_name.capitalized
        
        let defaultLink = "https://api.opendota.com"
        let completeLink = defaultLink + hero.img
        
        self.imageView.downloaded(from: completeLink)
        // круглость
        self.clipsToBounds = true
        self.imageView.layer.cornerRadius = self.imageView.frame.height / 2
        self.imageView.contentMode = .scaleAspectFill
    }
    
    // для переиспользования
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
    }
}
