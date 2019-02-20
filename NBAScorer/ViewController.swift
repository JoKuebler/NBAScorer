//
//  ViewController.swift
//  FirstApp
//
//  Created by Jonas Kübler on 03.02.19.
//  Copyright © 2019 Jonas.K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var requestButton: UIButton!
    
    @IBOutlet weak var awayScore: UILabel!
    //@IBOutlet weak var homeScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestButton.layer.cornerRadius = 15
        
        Requests.instance.getTodaysData { (result) in
            
            if let gameboxScore = result["gameboxscore"] as! NSDictionary? {

                if let quarterSummary = gameboxScore["quarterSummary"] as! NSDictionary? {
                    
                    if let quarterTotals = quarterSummary["quarterTotals"] as! NSDictionary? {
                        self.awayScore.text = quarterTotals["awayScore"]! as? String
                        //self.homeScore.text = quarterTotals["homeScore"]! as? String
                    }
                }
                
            }
        }
    }
    
}

