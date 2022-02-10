//
//  ViewController.swift
//  firstProject
//
//  Created by Igor on 29.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gameFieldView: UIView!
    @IBOutlet weak var shapeX: NSLayoutConstraint!
    @IBOutlet weak var shapeY: NSLayoutConstraint!
    @IBOutlet weak var gameObject: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameControl: GameControlViewClass!
    private var gameTimer: Timer?
    private var timer: Timer?
    private var displayDuration: TimeInterval = 2
    private var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.cornerRadius = 5
        updateUI()
        gameControl.startStopHandler = { [weak self] in
            self?.actionButtonTapped()
        }
        gameControl.gameDuration = 20

    }
    
    @IBAction func objectTapped(_ sender: UITapGestureRecognizer) {
        guard gameControl.isGameActive else { return }
        repositionImageWithTimer()
        score += 1
    }
    
    private func repositionImageWithTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(moveImage),
            userInfo: nil,
            repeats: true
        )
        timer?.fire()
    }
    
    private func startGame() {
        score = 0
        repositionImageWithTimer()
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(gameTimerTick),
            userInfo: nil,
            repeats: true
        )
        gameControl.gameTimeLeft = gameControl.gameDuration
        gameControl.isGameActive = true
        updateUI()
    }
    
    private func stopGame() {
        gameControl.isGameActive = false
        updateUI()
        gameTimer?.invalidate()
        timer?.invalidate()
        scoreLabel.text = "Последний счет: \(score)"
    }
    
    private func updateUI() {
        gameObject.isHidden = !gameControl.isGameActive
    }
    
    @objc private func gameTimerTick() {
        gameControl.gameTimeLeft -= 1
        if gameControl.gameTimeLeft <= 0 {
            stopGame()
        } else {
            updateUI()
        }
    }
    
    @objc private func moveImage() {
        let maxX = gameFieldView.bounds.maxX - gameObject.frame.width
        let maxY = gameFieldView.bounds.maxY - gameObject.frame.height
        shapeX.constant = CGFloat(arc4random_uniform(UInt32(maxX)))
        shapeY.constant = CGFloat(arc4random_uniform(UInt32(maxY)))
    }
    
    func actionButtonTapped() {
        if gameControl.isGameActive {
            stopGame()
        } else {
            startGame()
        }
    }
}
