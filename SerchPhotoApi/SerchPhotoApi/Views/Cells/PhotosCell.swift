//
//  PhotosCell.swift
//  SerchPhotoApi
//
//  Created by Igor on 29.03.2022.
//

import UIKit
import SDWebImage

class PhotosCell: UICollectionViewCell {
    
    static let reuseId = "PhotosCell"
    
    private let checkMark: UIImageView = {
        let image = UIImage(named: "checkmark")
        image?.withRenderingMode(.automatic)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoURL = unsplashPhoto.urls["regular"]
            guard let imageUrl = photoURL, let url = URL(string: imageUrl) else { return }
            
            photoImageView.sd_setImage(with: url)
        }
    }
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        // программно
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
    }
    
    private func updateSelectedState() {
        photoImageView.alpha = isSelected ? 0.7 : 1
        checkMark.alpha = isSelected ? 1 : 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPhotoImageView()
        setupCheckMarkView()
        updateSelectedState()
    }
    
    private func setupPhotoImageView() {
        addSubview(photoImageView)
        
        // contsrainting photoImageView
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    private func setupCheckMarkView() {
        addSubview(checkMark)
        
        // contsrainting checkMark
        checkMark.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -8).isActive = true
        checkMark.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
}
