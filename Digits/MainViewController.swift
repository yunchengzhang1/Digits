//
//  ViewController.swift
//  Digits
//
//  Created by Eric Larson on 8/24/21.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var topCenterLabel: UILabel!
    
    @IBAction func helloWorldTapped(_ sender: Any) {
        self.topCenterLabel.text = "Hello MSL World!"
    }
}

