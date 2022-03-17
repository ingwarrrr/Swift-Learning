//
//  TableViewCell.swift
//  CustomCellTableView
//
//  Created by Igor on 17.03.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryImgView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
