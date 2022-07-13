//
//  HandbookCollectionViewCell.swift
//  UIKit for iOS 15
//
//  Created by Sai Kambampati on 11/1/21.
//

import UIKit

class HandbookCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var logo: UIImageView!
    @IBOutlet var banner: UIImageView!
    @IBOutlet var overlay: UIView!
    
    let gradient = CAGradientLayer()
    
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
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = overlay.frame
        gradient.cornerCurve = .continuous
        gradient.cornerRadius = 30
        
        overlay.layer.insertSublayer(gradient, at: 0)
        overlay.layer.cornerRadius = 30
        overlay.layer.cornerCurve = .continuous
        
        // Accessibility
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.maximumContentSizeCategory = .extraExtraLarge
        titleLabel.font = UIFont.preferredFont(for: .headline, weight: .semibold)
        
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.maximumContentSizeCategory = .extraLarge
        subtitleLabel.font = UIFont.preferredFont(for: .caption2, weight: .regular)
        
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.maximumContentSizeCategory = .extraLarge
        descriptionLabel.font = UIFont.preferredFont(for: .caption2, weight: .regular)
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
    }
}
