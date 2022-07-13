//
//  SectionTableViewCell.swift
//  UIKit for iOS 15
//
//  Created by Sai Kambampati on 11/7/21.
//

import UIKit

class SectionTableViewCell: UITableViewCell {

    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var previewLabel: UILabel!
    @IBOutlet var logoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Accessibility
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.maximumContentSizeCategory = .extraExtraLarge
        titleLabel.font = UIFont.preferredFont(for: .headline, weight: .bold)
        
        courseLabel.adjustsFontForContentSizeCategory = true
        courseLabel.maximumContentSizeCategory = .extraLarge
        courseLabel.font = UIFont.preferredFont(for: .caption1, weight: .semibold)
        
        previewLabel.adjustsFontForContentSizeCategory = true
        previewLabel.maximumContentSizeCategory = .extraLarge
        previewLabel.font = UIFont.preferredFont(for: .caption1, weight: .regular)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
