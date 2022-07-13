//
//  SectionCollectionViewCell.swift
//  UIKit for iOS 15
//
//  Created by Sai Kambampati on 11/1/21.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var logo: UIImageView!
    @IBOutlet var banner: UIImageView!
        
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(named: "Shadow")!.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
        layer.masksToBounds = false
        layer.cornerRadius = 30
        layer.cornerCurve = .continuous
        
        // Accessibility
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.maximumContentSizeCategory = .extraExtraLarge
        titleLabel.font = UIFont.preferredFont(for: .body, weight: .bold)
        
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.maximumContentSizeCategory = .extraLarge
        subtitleLabel.font = UIFont.preferredFont(for: .caption1, weight: .regular)
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
    }
}
