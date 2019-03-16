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
    var scoreBoardResult = JSON()
    var teamStandingResult = JSON()
    var teamScore = 0.0
    var standingScore = 0.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set Navigation Bar Title and make it bigger
        navigationItem.title = "Last Night's Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Get last nights games
        Requests.instance.getScoreBoard { (lastNightGames) in
            
            // Easy access with SwiftyJSON
            self.scoreBoardResult = JSON(lastNightGames)
            // Count amount of games
            self.lastGamesCount = self.scoreBoardResult["games"].count

            // Reload TableView when Data is ready
            self.tableView.reloadData()
            
        }
        
        Requests.instance.getTeamStandings { (teamStandings) in
            
            self.teamStandingResult = JSON(teamStandings)
            
            // Reload TableView when Data is ready
            self.tableView.reloadData()
            
        }
        
        // Table View Settings
        let tableViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.contentInset = tableViewInsets
        
        // Register Cell
        self.tableView.register(GameCell.self, forCellReuseIdentifier: Constants.instance.cellID)
        
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
        
        // Get and style GameCell: No grey background on touch and Change backgroundcolor of cells
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.instance.cellID) as! GameCell
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        
        // Get daily Game Entries
        let gameEntries = self.scoreBoardResult["games"]
        
        // Assign each entry to one row
        let singleGame = gameEntries[indexPath.row]
        
        // Get abbreviation for easy use later
        let curAbrAway = singleGame["schedule"]["awayTeam"]["abbreviation"].string
        let curAbrHome = singleGame["schedule"]["homeTeam"]["abbreviation"].string
        
        // Calculate Scores
        self.teamScore = Scoring.instance.calculateTeamScore(scoreBoardJson: singleGame)
        self.standingScore = Scoring.instance.calculateTeamStandScore(standingJson: self.teamStandingResult)
        
        // Set values of UILabels and UIImages
        cell.teamNameAway.text = Constants.instance.teamNames[curAbrAway!]
        cell.teamNameHome.text = Constants.instance.teamNames[curAbrHome!]
        cell.arenaName.text = singleGame["schedule"]["venue"]["name"].string
        cell.iconAway.image = UIImage(named: curAbrAway! + ".png")!
        cell.iconHome.image = UIImage(named: curAbrHome! + ".png")!
        cell.scoreExcitement.text = "\(self.teamScore)"
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 145
    }
    
    
}

