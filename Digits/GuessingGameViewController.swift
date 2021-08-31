//
//  GuessingGameViewController.swift
//  Digits
//
//  Created by Eric Larson on 8/31/21.
//

import UIKit

class GuessingGameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userFeedback: UILabel!
    
    var numToGuess:Int = 0
    var guessedNum:Int = 0 {
        didSet{
            DispatchQueue.main.async {
                // working with the switch statement
                // here to show off its power
                switch self.guessedNum {
                case self.numToGuess:
                    self.userFeedback.text = "Correct!"
                    
                case let x where x<self.numToGuess:
                    // added an example animation here
                    UIView.transition(with: self.userFeedback,
                                      duration: 3,
                                      options: .transitionFlipFromRight,
                                      animations: {
                                        self.userFeedback.text = "Higher!"
                                      },
                                      completion: nil)
                    
                case let x where x>self.numToGuess:
                    self.userFeedback.text = "Lower!"
                    
                default:
                    self.userFeedback.text = "Please enter a number"
                }
                
               
            }
            
        }
    }
    
    @IBOutlet weak var guessNumTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userFeedback.text = "Guess a number from 0-100"
        randomize()
        guessNumTextField.delegate = self
    }
    
    // random integer less thatn 100
    func randomize(){
        self.numToGuess = Int.random(in: 0..<100)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let num = Int(textField.text!){
            self.guessedNum = num
        }else{
            userFeedback.text = "Please enter numbers only"
        }
        
        textField.resignFirstResponder()
        return true
    }

    @IBAction func didCancelKeyboard(_ sender: Any) {
        self.guessNumTextField.resignFirstResponder()
    }
    
    

}
