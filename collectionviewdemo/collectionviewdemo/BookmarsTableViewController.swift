//
//  BookmarsTableViewController.swift
//  collectionviewdemo
//
//  Created by Igor on 04.06.2022.
//

import UIKit

class BookmarsTableViewController: UITableViewController {
    
    var bookmarks: Array<Dictionary<String, String>> = allBookmarks

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell") as! BookmarkTableViewCell
        let bookmark = bookmarks[indexPath.row]
        
        cell.chapterTitleLable?.text = bookmarks[indexPath.row]["section"]?.uppercased()
        cell.titleLabel.text = bookmark["part"]
        cell.bodyLabel.text = bookmark["content"]
        cell.chapterNumberLabel.text = bookmark["chapter"]
        cell.badgeImageView.image = UIImage(named: "Bookmarks/" + bookmark["type"]!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "Bookmarks to Section", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Bookmarks to Section", let destionation = segue.destination as? SectionViewController {
            destionation.section = sections[0]
            destionation.sections = sections
            destionation.indexPath = sender as? IndexPath
        }
    }
}
