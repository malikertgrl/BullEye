//
//  ViewController.swift
//  BullsEye
//
//  Created by Murat Adıgüzel on 28.05.2021.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    
    var targetValue = 0
    var currentValue = 0
    var score = 0
    var round = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        
    }
    func startNewRound() {
        round += 1
        currentValue = 50
        slider.value = Float(currentValue)
        targetValue = Int.random(in: 1...100)
        updateLabels()
    }

    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()

        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }

    func updateLabels() {
        targetLabel.text = "\(targetValue)"
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
    }

    @IBAction func showAlert() {
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference

        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }

        score += points

        let message = "You scored \(points) points."

        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        let action = UIAlertAction(title: "OK",
                                   style: .default) { _ in
                                    self.startNewRound()
                                   }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }

}

