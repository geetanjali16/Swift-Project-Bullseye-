//
//  ViewController.swift
//  BullsEye
//
//  Created by Geetanjali on 22/05/19.
//  Copyright © 2019 Geetanjali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue = 0
    @IBOutlet weak var slider: UISlider!
    var targetValue = 0
    @IBOutlet weak var targetLabel: UILabel!
    var score = 0
    @IBOutlet weak var scoreLable: UILabel!
    var round = 0
    @IBOutlet weak var roundLable: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func sliderMoved(_ slider: UISlider){
        print("the value of a slider is \(slider.value)")
        currentValue = lroundf(slider.value)
        //startNewRound()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal"); slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumImageHighlighted = UIImage(named: "SliderThumb-Highlighte"); slider.setThumbImage(thumImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    
    func updateLables(){
        targetLabel.text = String(targetValue)
        scoreLable.text = String(score)
        roundLable.text = String(round)

    }
    
    func startNewRound(){
        round = round + 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLables()
        
    }
    
    @IBAction func showAlert(){
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        score = score + points

        
        let title: String
        if difference == 0{
            title = "Perfect"
            points = points + 100
        }else if difference < 5{
            if difference == 1{
                points = points + 50
            }
            title = "You are almost close to score!"
            
        }else if difference < 10{
            title = "Preety good!"
        }else{
            title = "Not even close "
        }

        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "awsome", style: .default, handler: {
            action in self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func startNewGame(){
        round = 0
        score = 0
        startNewRound()
    }


}

