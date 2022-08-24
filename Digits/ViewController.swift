//
//  ViewController.swift
//  Digits
//
//  Created by Eric Larson on 8/24/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var topCenterLabel: UILabel!
    
    @IBOutlet weak var botCenterLabel: UILabel!
    @IBOutlet weak var helloButton: UIButton!
    weak var counter 
    
    @IBAction func helloWorldTapped(_ sender: Any) {
        self.topCenterLabel.text = "Hello MSL World!"
        self.botCenterLabel.text = "hello world"
        self.helloButton.setTitle("button clicked", for: .normal)
    }
}

