//
//  GameControlViewClass.swift
//  firstProject
//
//  Created by Igor on 10.02.2022.
//

import UIKit

@IBDesignable
class GameControlViewClass: UIView {
    private let timeLabel = UILabel()
    private let stepper = UIStepper()
    private let actionButton = UIButton()
    
    @IBInspectable var gameTimeLeft: Double = 7 {
        didSet {
            updateUI()
        }
    }
    @IBInspectable var isGameActive: Bool = false {
        didSet {
            updateUI()
        }
    }
    @IBInspectable var gameDuration: Double {
        get {
            return stepper.value
        }
        set {
            stepper.value = newValue
            updateUI()
        }
    }
    var startStopHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private let timeToStepperMargin: CGFloat = 8
    private let actionButtonTopMargin: CGFloat = 8
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let stepperSize = stepper.intrinsicContentSize
        stepper.frame = CGRect(
            origin: CGPoint(
                x: bounds.maxX - stepperSize.width,
                y: bounds.minY),
            size: stepperSize)
        
        let timeLabelSize = timeLabel.intrinsicContentSize
        timeLabel.frame = CGRect(
            origin: CGPoint(
                x: bounds.minX,
                y: bounds.minY + (stepperSize.height - timeLabelSize.height) / 2),
            size: timeLabelSize)
        
        let buttonSize = actionButton.intrinsicContentSize
        actionButton.frame = CGRect(
            origin: CGPoint(
                x: bounds.minX + (bounds.width - buttonSize.width) / 2,
                y: stepper.frame.maxY + actionButtonTopMargin),
            size: buttonSize)
    }
    
    override var intrinsicContentSize: CGSize {
        let stepperSize = stepper.intrinsicContentSize
        let timeLabelSize = timeLabel.intrinsicContentSize
        let buttonSize = actionButton.intrinsicContentSize
        
        let width = timeLabelSize.width + timeToStepperMargin + stepperSize.width
        let height = stepperSize.height + actionButtonTopMargin + buttonSize.height
        
        return CGSize(width: width, height: height)
    }
    
    private func setupViews() {
        addSubview(timeLabel)
        addSubview(stepper)
        addSubview(actionButton)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = true
        stepper.translatesAutoresizingMaskIntoConstraints = true
        actionButton.translatesAutoresizingMaskIntoConstraints = true
        
        stepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        updateUI()
        actionButton.setTitleColor(actionButton.tintColor, for: .normal)
    }
    
    private func updateUI() {
        stepper.isEnabled = !isGameActive
        if isGameActive {
            timeLabel.text = "Осталось \(Int(gameTimeLeft)) сек"
            actionButton.setTitle("Остановить", for: .normal)
        } else {
            timeLabel.text = "Время: \(Int(stepper.value)) сек"
            actionButton.setTitle("Начать", for: .normal)
        }
        setNeedsLayout()
    }
    
    @objc func stepperChanged() {
        updateUI()
    }
    
    @objc func actionButtonTapped() {
        startStopHandler?()
    }
}
