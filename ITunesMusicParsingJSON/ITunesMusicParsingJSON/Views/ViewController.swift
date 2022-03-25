//
//  ViewController.swift
//  ITunesMusicParsingJSON
//
//  Created by Igor on 24.03.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var table: UITableView!
    
    let networkDataFetcher = NetworkDataFetcher()
    var music: Music? = nil
    private var timer: Timer?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
    }

    private func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = music?.results.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let track = music?.results[indexPath.row]
        cell.textLabel?.text = track?.trackName
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&limit=25"

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.networkDataFetcher.fetchTracks(urlStr: urlString) { [weak self] resMusic in
                guard let resMusic = resMusic else {
                    return
                }
                self?.music = resMusic
                self?.table.reloadData()
            }
        })
    }
}
