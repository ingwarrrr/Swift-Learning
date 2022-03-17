//
//  HeroViewController.swift
//  DotaTableVC
//
//  Created by Igor on 16.03.2022.
//

import UIKit

class HeroViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var legsLabel: UILabel!
    
    var hero: HeroStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = hero?.localized_name
        attackLabel.text = hero?.primary_attr
        attributeLabel.text = hero?.attack_type
        legsLabel.text = "\((hero?.legs)!)"
        
        let defaultLink = "https://api.opendota.com"
        let completeLink = defaultLink + hero!.img
        imageView.downloaded(from: completeLink)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
