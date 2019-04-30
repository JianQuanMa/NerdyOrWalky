//
//  ViewController.swift
//  NerdyOrWalky
//
//  Created by Jian Ma on 4/21/19.
//  Copyright © 2019 Jian Ma. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var nerdyButton: UIButton!
    @IBOutlet weak var walkedButton: UIButton!
    @IBOutlet weak var feelLabel: UILabel!
    
    private enum Segue {
        static let toMapViewController = "toMapViewController"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        feelLabel.text = "How are you feeling today?"
    }
    
    @IBAction func nerdyButton(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.toMapViewController, sender: sender)
    }
    
    @IBAction func walkyButton(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.toMapViewController, sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("-=- this will happen before it nagigates over \(sender)")
    }
}

