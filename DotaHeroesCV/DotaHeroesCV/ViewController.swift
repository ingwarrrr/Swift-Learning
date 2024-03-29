//
//  ViewController.swift
//  DotaHeroesCV
//
//  Created by Igor on 13.03.2022.
//

import UIKit

struct Hero: Codable {
    let localized_name: String
    let img: String
}

class ViewController: UIViewController {
    
    var heroes = [Hero]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        // parsing
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            if error == nil {
                do {
                    self.heroes = try JSONDecoder().decode([Hero].self, from: data!)
                } catch {
                    print("Parsing error!")
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        }.resume()
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

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
        
//        cell.nameLabel.text = heroes[indexPath.row].localized_name.capitalized
//
//        let defaultLink = "https://api.opendota.com"
//        let completeLink = defaultLink + heroes[indexPath.row].img
//
//        cell.imageView.downloaded(from: completeLink)
//        // круглость
//        cell.clipsToBounds = true
//        cell.imageView.layer.cornerRadius = cell.imageView.frame.height / 2
//        cell.imageView.contentMode = .scaleAspectFill
        
        // вместо того что выше вызываем
        cell.setupCell(hero: heroes[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
}
