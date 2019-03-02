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
    var lastNightJson = JSON()
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
            self.lastNightJson = JSON(lastNightGames)
            // Count amount of games
            self.lastGamesCount = self.lastNightJson["dailygameschedule"]["gameentry"].count
            // Reload TableView when Data is ready
            self.tableView.reloadData()
            
        }
        
        let tableViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.contentInset = tableViewInsets
        
        
        // Register Cell
        self.tableView.register(GameCell.self, forCellReuseIdentifier: cellID)
        
    }
    
    
    
    /**
     Returns amount of cells needed
     
     :param:
     
     :returns: gamecount
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.lastGamesCount
        return 3
    }
    
    
    /**
     Defines how cell should look like
     
     :param:
     
     :returns: cell
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! GameCell
        
        // Get daily Game Entries
        let gameEntries = self.lastNightJson["dailygameschedule"]["gameentry"]
        // Assign each entry to one row
        let singleGame = gameEntries[indexPath.row]
        
        // No grey background on touch
        cell.selectionStyle = .none
        // Change backgroundcolor of cells
        cell.contentView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        
        // Set values of UILabels and UIImages
        cell.teamNameAway.text = singleGame["awayTeam"]["Abbreviation"].string
        cell.teamNameHome.text = singleGame["homeTeam"]["Abbreviation"].string
        cell.arenaName.text = singleGame["location"].string
        cell.iconHome.image = UIImage(named: "hawks.png")!
        cell.iconAway.image = UIImage(named: "hawks.png")!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 140
    }
    
    
}

