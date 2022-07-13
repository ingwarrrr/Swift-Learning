//
//  CourseViewController.swift
//  UIKit for iOS 15
//
//  Created by Sai Kambampati on 11/5/21.
//

import UIKit
import Combine

class CourseViewController: UIViewController {
    var course: Course?

    @IBOutlet var bannerImage: UIImageView!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var iconImageView: CustomImageView!
    @IBOutlet var menuButton: UIButton!
    
    @IBOutlet var sectionsTableView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    private var tokens: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.iconImageView.image = course?.courseIcon
        self.bannerImage.image = course?.courseBanner
        self.backgroundImage.image = course?.courseBackground
        self.titleLabel.text = course?.courseTitle
        self.subtitleLabel.text = course?.courseSubtitle
        self.descriptionLabel.text = course?.courseDescription
        self.authorLabel.text = "Taught by \(course?.courseAuthor?.formatted(.list(type: .and, width: .standard)) ?? "Design+Code")"
        
        // Table View
        self.sectionsTableView.delegate = self
        self.sectionsTableView.dataSource = self
        self.sectionsTableView.rowHeight = UITableView.automaticDimension
        self.sectionsTableView.estimatedRowHeight = UITableView.automaticDimension

        // Subscribe to table view changes
        sectionsTableView
            .publisher(for: \.contentSize)
            .sink { contentSize in
            self.tableViewHeight.constant = contentSize.height + 10
        }
        .store(in: &tokens)
        
        // Add UIMenu
        let menu = UIMenu(
            title: "Course Options",
            options: .displayInline,
            children: [
                UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up"), handler: { _ in
                    
                }),
                UIAction(title: "Take Test", image: UIImage(systemName: "highlighter"), handler: { _ in
                    
                }),
                UIAction(title: "Download", image: UIImage(systemName: "square.and.arrow.down"), handler: { _ in
                    
                }),
                UIAction(title: "Forums", image: UIImage(systemName: "chevron.left.forwardslash.chevron.right"), handler: { _ in
                    
                })
            ]
        )
        menuButton.showsMenuAsPrimaryAction = true
        menuButton.menu = menu
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension CourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.course?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath) as! SectionTableViewCell
        if let course = course {
            let section = course.sections[indexPath.row]
            
            cell.titleLabel.text = section.sectionTitle
            cell.courseLabel.text = course.courseTitle
            cell.previewLabel.text = section.sectionDescription
            cell.logoImageView.image = course.courseIcon
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
