//
//  QuestionCollectionViewCell.swift
//  DesignCodeApp
//
//  Created by Igor on 
//

import UIKit

protocol QuestionCellDelegate : class {
    func questionCell(_ cell : QuestionCollectionViewCell, didTapButton button : UIButton, forQuestion question : Dictionary<String,Any>)
}

class QuestionCollectionViewCell: UICollectionViewCell {

    weak var delegate : QuestionCellDelegate?
    var question : Dictionary<String,Any>!

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!

    @IBAction func didTapQuestionButton(_ sender: UIButton) {

        delegate?.questionCell(self, didTapButton: sender, forQuestion: question)

        sender.setImage(UIImage(named: "Exercises-Check"), for: .normal)
    }
}
