//
//  MainTabBarController.swift
//  SerchPhotoApi
//
//  Created by Igor on 28.03.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photosVC = PhotosCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        viewControllers = [
            generateNavController(rootVC: photosVC, title: "Photos", image: UIImage(named: "gallery")!),
            generateNavController(rootVC: ViewController(), title: "Likes", image: UIImage(named: "like")!)
        ]
    }
    
    func generateNavController(rootVC rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        
        return navigationVC
    }
}
