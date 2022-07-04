//
//  UIImageView+Kingfisher.swift
//  DesignCodeApp
//
//  Created by Igor on 
//

import Kingfisher

extension UIImageView {

    @discardableResult
    func setImage(from url: URL, with placeholder: UIImage? = nil, completion: CompletionHandler? = nil) -> RetrieveImageTask? {

        ImageCache.default.retrieveImage(forKey: url.absoluteString, options: [], completionHandler: {
            image, _ in
            self.image = image
        })

        return kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.2))],
            progressBlock: nil,
            completionHandler: completion)
    }
}
