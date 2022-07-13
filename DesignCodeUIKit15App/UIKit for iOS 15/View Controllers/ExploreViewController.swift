//
//  ExploreViewController.swift
//  UIKit for iOS 15
//
//  Created by Igor on 06/23/22.
//

import UIKit
import Combine

class ExploreViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var topicsLabel: UILabel!
    @IBOutlet var popularLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var sectionsCollectionView: UICollectionView!
    @IBOutlet var popularCollectionView: UICollectionView!
    @IBOutlet var topicsTableView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!

    private var tokens: Set<AnyCancellable> = []
    private var lastScrollYPosition: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Collection View
        self.sectionsCollectionView.delegate = self
        self.sectionsCollectionView.dataSource = self
        self.sectionsCollectionView.layer.masksToBounds = false
        self.popularCollectionView.delegate = self
        self.popularCollectionView.dataSource = self
        self.popularCollectionView.layer.masksToBounds = false

        // Table View
        self.topicsTableView.delegate = self
        self.topicsTableView.dataSource = self
        self.topicsTableView.layer.masksToBounds = true
        
        // Subscribe to table view changes
        topicsTableView
            .publisher(for: \.contentSize)
            .sink { contentSize in
            self.tableViewHeight.constant = contentSize.height + 10
        }
        .store(in: &tokens)
        
        // Subscribe to scroll view changes
        scrollView.delegate = self
        
        // Accessibility
        titleLabel.maximumContentSizeCategory = .accessibilityExtraLarge
        titleLabel.font = UIFont.preferredFont(for: .title2, weight: .bold)
        titleLabel.adjustsFontForContentSizeCategory = true
        
        topicsLabel.maximumContentSizeCategory = .accessibilityMedium
        topicsLabel.font = UIFont.preferredFont(for: .footnote, weight: .semibold)
        topicsLabel.adjustsFontForContentSizeCategory = true
        
        popularLabel.maximumContentSizeCategory = .accessibilityMedium
        popularLabel.font = UIFont.preferredFont(for: .footnote, weight: .semibold)
        popularLabel.adjustsFontForContentSizeCategory = true
    }
}


extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sectionsCollectionView {
            return sections.count
        } else {
            return handbooks.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sectionsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionCell", for: indexPath) as! SectionCollectionViewCell
            let section = sections[indexPath.item]
            
            cell.titleLabel.text = section.sectionTitle
            cell.subtitleLabel.text = section.sectionSubtitle
            cell.logo.image = section.sectionIcon
            cell.banner.image = section.sectionBanner

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseCell", for: indexPath) as! HandbookCollectionViewCell
            let handbook = handbooks[indexPath.item]

            cell.titleLabel.text = handbook.courseTitle
            cell.subtitleLabel.text = handbook.courseSubtitle
            cell.descriptionLabel.text = handbook.courseDescription
            cell.gradient.colors = handbook.courseGradient
            cell.logo.image = handbook.courseIcon
            cell.banner.image = handbook.courseBanner

            return cell
        }
    }
}

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicTableViewCell
        let topic = topics[indexPath.row]
        
        cell.topicLabel.text = topic.topicName
        cell.topicLogo.image = UIImage(systemName: topic.topicSymbol)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ExploreViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.lastScrollYPosition = scrollView.contentOffset.y
        let totalScrollHeight = scrollView.contentSize.height
        let percentage = lastScrollYPosition / totalScrollHeight
        
        if percentage <= 0.2 {
            self.titleLabel.text = "Recent"
        } else if percentage <= 0.6 {
            self.titleLabel.text = "Topics"
        } else {
            self.titleLabel.text = "Popular"
        }
    }
}
