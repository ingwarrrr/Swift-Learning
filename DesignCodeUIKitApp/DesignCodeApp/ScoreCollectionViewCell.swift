//
//  ScoreCollectionViewCell.swift
//  DesignCodeApp
//
//  Created by Igor on 
//

import UIKit
import MKRingProgressView

protocol ScoreCellDelegate : class {
    func scoreCell(_ cell : ScoreCollectionViewCell, didTapShareExercise exercise : Array<Dictionary<String,Any>>)
    func scoreCell(_ cell : ScoreCollectionViewCell, didTapTryAgainExercise exercise : Array<Dictionary<String,Any>>)
}

class ScoreCollectionViewCell: UICollectionViewCell {

    weak var delegate : ScoreCellDelegate?

    @IBOutlet var percentageLabel : UILabel!
    @IBOutlet var percentageView : MKRingProgressView!

    var exercise : Array<Dictionary<String,Any>>!

    override func awakeFromNib() {

        percentageLabel.animateTo(72)
        percentageView.animateTo(72)
    }

    @IBAction func shareButtonTapped(_ sender: UIButton) {
        delegate?.scoreCell(self, didTapShareExercise: exercise)
    }

    @IBAction func againButtonTapped(_ sender: UIButton) {
        delegate?.scoreCell(self, didTapTryAgainExercise: exercise)
    }
}
