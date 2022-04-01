//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Igor on 01.04.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var tableView = UITableView()
    private var videoLinks: [String] = ["https://instagram.fmnl25-2.fna.fbcdn.net/v/t50.2886-16/161454505_126220179452986_7645785967961263824_n.mp4?_nc_ht=instagram.fmnl25-2.fna.fbcdn.net&_nc_cat=110&_nc_ohc=teeLtDVe9xMAX_lteI2&ccb=7-4&oe=605830BD&oh=add9716a62da11965e91cf90523ba002&_nc_sid=83d603", "https://instagram.fcgk30-1.fna.fbcdn.net/v/t50.2886-16/160645983_739580000063590_3137969578785779462_n.mp4?_nc_ht=instagram.fcgk30-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=25epai85VXYAX8Gde9z&ccb=7-4&oe=605989D3&oh=30c9c8474b06c0a4d5e6d5fdcfa5e073&_nc_sid=83d603", "https://instagram.fsin9-1.fna.fbcdn.net/v/t50.2886-16/160242410_491585305339867_8737078020931524871_n.mp4?_nc_ht=instagram.fsin9-1.fna.fbcdn.net&_nc_cat=107&_nc_ohc=Tr3Eu9Os88EAX-Z5F8i&ccb=7-4&oe=60595EC3&oh=a522ebf2bf71dee1100497a873e0d240", "https://instagram.fcok4-1.fna.fbcdn.net/v/t50.2886-16/161092934_246935930440568_8175537815544894451_n.mp4?_nc_ht=instagram.fcok4-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=S78ggB6m9BgAX_uL6N3&ccb=7-4&oe=6058E3A8&oh=28500682ee17c3233b5917a74b9c3430"]
    private var battonsName: [String] = ["home","search","plus","mail","user"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupTableView()
        setupButtonsStack()
    }
    
    private func setupTableView() {
        tableView.isPagingEnabled = true
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(tableView)
        // snapKit
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupButtonsStack() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
//        setapStackBackground()
        
        for name in battonsName {
            let button = UIButton()
            button.setImage(UIImage(named: name), for: .normal)
            
            stackView.addArrangedSubview(button)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(35)
            make.height.equalTo(60)
        }
    }

    private func setapStackBackground() {
        let blackView = UIView()
        blackView.backgroundColor = .black
        view.addSubview(blackView)
        blackView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDataSource

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoLinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return VideoTableViewCell(link: videoLinks[indexPath.item])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
