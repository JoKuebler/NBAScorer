//
//  ViewController.swift
//  FirstApp
//
//  Created by Jonas Kübler on 03.02.19.
//  Copyright © 2019 Jonas.K. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = "Last Night's Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        Requests.instance.getTodaysGames { (todayGames) in
//            print(todayGames)
//        }
//
//        // Get todays games
//        Requests.instance.getTodaysData { (result) in
//            let json = JSON(result)
//
//            self.awayScore.text = json["gameboxscore"]["quarterSummary"]["quarterTotals"]["awayScore"].stringValue
//            self.homeScore.text = json["gameboxscore"]["quarterSummary"]["quarterTotals"]["homeScore"].stringValue
//        }
        
    }
    
}

