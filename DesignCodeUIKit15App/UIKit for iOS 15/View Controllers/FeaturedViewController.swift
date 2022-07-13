//
//  FeaturedViewController.swift
//  UIKit for iOS 15
//
//  Created by Sai Kambampati on 10/23/21.
//

import UIKit
import Combine

class FeaturedViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var handbooksCollectionView: UICollectionView!
    @IBOutlet var coursesTableView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var featuredTitleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var previewLabel: UILabel!
    @IBOutlet var handbooksLabel: UILabel!
    @IBOutlet var coursesLabel: UILabel!
    
    private var tokens: Set<AnyCancellable> = []
    private var lastScrollYPosition: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Collection View
        self.handbooksCollectionView.delegate = self
        self.handbooksCollectionView.dataSource = self
        self.handbooksCollectionView.layer.masksToBounds = false
        
        // Table View
        self.coursesTableView.delegate = self
        self.coursesTableView.dataSource = self
        self.coursesTableView.layer.masksToBounds = false
        
        // Subscribe to table view changes
        coursesTableView.publisher(for: \.contentSize)
            .sink { contentSize in
                self.tableViewHeight.constant = contentSize.height
            }
            .store(in: &tokens)
        
        // Scroll View
        self.scrollView.delegate = self
        
        // Accessibility
        featuredTitleLabel.maximumContentSizeCategory = .accessibilityExtraLarge
        featuredTitleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        featuredTitleLabel.adjustsFontForContentSizeCategory = true
        
        infoLabel.maximumContentSizeCategory = .accessibilityMedium
        infoLabel.font = UIFont.preferredFont(for: .footnote, weight: .bold)
        infoLabel.adjustsFontForContentSizeCategory = true
        
        previewLabel.maximumContentSizeCategory = .accessibilityMedium
        previewLabel.font = UIFont.preferredFont(for: .footnote, weight: .regular)
        previewLabel.adjustsFontForContentSizeCategory = true
        
        handbooksLabel.maximumContentSizeCategory = .accessibilityMedium
        handbooksLabel.font = UIFont.preferredFont(for: .footnote, weight: .semibold)
        handbooksLabel.adjustsFontForContentSizeCategory = true
        
        coursesLabel.maximumContentSizeCategory = .accessibilityMedium
        coursesLabel.font = UIFont.preferredFont(for: .footnote, weight: .semibold)
        coursesLabel.adjustsFontForContentSizeCategory = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? CourseViewController, let course = sender as? Course {
            detailsViewController.course = course
        }
    }
    
}

extension FeaturedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return handbooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

extension FeaturedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseTableCell", for: indexPath) as! CourseTableViewCell
        let course = courses[indexPath.section]
        
        cell.titleLabel.text = course.courseTitle
        cell.subtitleLabel.text = course.courseSubtitle
        cell.descriptionLabel.text = course.courseDescription
        cell.courseBackground.image = course.courseBackground
        cell.courseBanner.image = course.courseBanner
        cell.courseLogo.image = course.courseIcon
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let course = courses[indexPath.section]
        performSegue(withIdentifier: "popupCourse", sender: course)
    }
}

extension FeaturedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.lastScrollYPosition = scrollView.contentOffset.y
        let totalScrollHeight = scrollView.contentSize.height
        let percentage = lastScrollYPosition / totalScrollHeight
        
        if percentage <= 0.1 {
            self.title = "Featured"
        } else if percentage <= 0.3 {
            self.title = "Handbooks"
        } else {
            self.title = "Courses"
        }
    }
}
