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
    
    // Count of games to determine table rows
    var lastGamesCount = 0
    // Cell ID for reference
    let cellID = "gameCells"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set Navigation Bar Title and make it bigger
        navigationItem.title = "Last Night's Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Get last nights games
        Requests.instance.getLastNight { (lastNightGames) in
            
            // Easy access with SwiftyJSON
            let lastNightJson = JSON(lastNightGames)
            // Count amount of games
            self.lastGamesCount = lastNightJson["dailygameschedule"]["gameentry"].count
            // Reload TableView when Data is ready
            self.tableView.reloadData()
            
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register Cell
        tableView.register(GameCell.self, forCellReuseIdentifier: cellID)
    
    }
    
    /**
     Returns amount of cells needed
     
     :param:
     
     :returns: gamecount
    */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lastGamesCount
    }
    
    /**
     Defines how cell should look like
     
     :param:
     
     :returns: cell
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! GameCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150
    }
    
}

