//
//  ViewController.swift
//  custom-controls
//
//  Created by patelpra on 4/16/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func updateRating(_ ratingControl: CustomControl) {
        let stars = ratingControl.value == 1 ? "star" : "stars"
        self.title = "User Rating: \(ratingControl.value) \(stars)"
        
    }
}

