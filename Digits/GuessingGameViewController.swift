//
//  GuessingGameViewController.swift
//  Digits
//
//  Created by Eric Larson.
//

import UIKit

class GuessingGameViewController: UIViewController, UITextFieldDelegate {

    var numToGuess:Int = 0
    
    // MARK: Game Logic
    // this should really be in a model that reflects the guessing game, but
    // we are abusing that here for a simple example.
    var guessedNum:Int = 0 {
        didSet{
            self.updateUIWithGuess()
        }
    }
    
    func updateUIWithGuess(){
        DispatchQueue.main.async {
            // working with the switch statement
            // here to show off its power
            var txt = ""
            var trackTxt = self.trackingLabel.text!
            var anim = UIView.AnimationOptions.transitionCrossDissolve
            var duration = 0.33
            
            switch self.guessedNum {
            case self.numToGuess:
                txt = "Correct!"
                trackTxt += "  \(self.guessedNum)!!  "
                duration = 2
                anim = .transitionFlipFromRight
                self.gameWasWon()
            case let x where x<self.numToGuess:
                txt = "Higher"
                trackTxt += ">\(x), "
            case let x where x>self.numToGuess:
                txt = "Lower"
                trackTxt += "<\(x), "
            default:
                txt = "Please enter a number"
            }
            
            // update the user feedback
            UIView.transition(with: self.userFeedback,
                              duration: duration,
                              options: anim,
                              animations: {
                                self.userFeedback.text = txt
                              },
                              completion: nil)
            
            // update the total guesses
            UIView.transition(with: self.trackingLabel,
                              duration: 0.33,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.trackingLabel.text = trackTxt
                              },
                              completion: nil)
            
            
           
        }
    }
    
    // MARK: UI Outlets
    @IBOutlet weak var userFeedback: UILabel!
    @IBOutlet weak var trackingLabel: UILabel!
    @IBOutlet weak var guessNumTextField: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    
    // MARK: UI Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        guessNumTextField.delegate = self
        
        
        guessButton.layer.borderWidth = 3
        guessButton.layer.cornerRadius = 20
        guessButton.layer.borderColor = UIColor.blue.cgColor
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.makeNewGame()
        
        
    }
    
    // MARK: UI Actions
    @IBAction func makeNewGame(_ sender: Any) {
        self.makeNewGame()
    }
    
    func makeNewGame(){
        // reset the state of the game
        randomize()
        
        UIView.transition(with: self.userFeedback,
                          duration: 0.33,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.userFeedback.text = "I'm thinking of a number from 0-100"
                          },
                          completion: nil)
        
        self.trackingLabel.text = "Guesses: "
        UIView.transition(with: self.guessButton,
                          duration: 0.33,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.guessButton.isEnabled = true
                            self.guessButton.setTitleColor(UIColor.white, for: .normal)
                            self.guessButton.backgroundColor = .systemBlue
                            self.guessButton.layer.borderColor = UIColor.blue.cgColor
                            self.guessButton.layer.opacity = 1.0
                          }, completion: nil)
        
        self.guessNumTextField.becomeFirstResponder()
    }
    
    func gameWasWon(){
        UIView.transition(with: self.guessButton,
                          duration: 0.33,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.guessButton.setTitleColor(UIColor.gray, for: .disabled)
                            self.guessButton.backgroundColor = .systemGray2
                            self.guessButton.isEnabled = false
                            self.guessButton.layer.borderColor = UIColor.gray.cgColor
                            self.guessButton.layer.opacity = 0.5
                          }, completion: nil)
        
        self.guessNumTextField.resignFirstResponder()
        
        
        // change the background red, then back to background
        UIView.transition(with: self.view,
                          duration: 2,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.view.backgroundColor = .systemRed
                          },
                          completion: {_ in
                            UIView.transition(with: self.view,
                                              duration: 2,
                                              options: .transitionCrossDissolve,
                                              animations: {
                                                self.view.backgroundColor = .systemBackground
                                              },
                                              completion: nil)
                          })
        
    }
    
    

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        interpretGuess()
        return true
    }

    @IBAction func didCancelKeyboard(_ sender: Any) {
        self.guessNumTextField.resignFirstResponder()
    }
    
    
    @IBAction func makeGuess(_ sender: Any) {
        interpretGuess()
        
    }
    
    // MARK: Utility Functions
    // random integer less than 100
    func randomize(){
        self.numToGuess = Int.random(in: 0..<100)
    }
    
    func interpretGuess(){
        if let num = Int(guessNumTextField.text!),
           num>=0,
           num<100{
            self.guessedNum = num
        }else{
            // update the user feedback
            self.userFeedback.text = ""
            UIView.transition(with: self.userFeedback,
                              duration: 0.33,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.userFeedback.text = "Please enter numbers only, 0-100"
                              },
                              completion: nil)
        }
        
        guessNumTextField.text = ""
        
        
    }
}
