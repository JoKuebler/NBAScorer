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
//        Requests.instance.getLastNight { (lastNightGames) in
//
//            // Easy access with SwiftyJSON
//            let lastNightJson = JSON(lastNightGames)
//            // Count amount of games
//            self.lastGamesCount = lastNightJson["dailygameschedule"]["gameentry"].count
//            // Reload TableView when Data is ready
//            self.tableView.reloadData()
//
//        }
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font Names: \(names)")
//        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
        // Register Cell
        self.tableView.register(GameCell.self, forCellReuseIdentifier: cellID)
        
    }
    
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 10
//    }
    
    /**
     Returns amount of cells needed
     
     :param:
     
     :returns: gamecount
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // Set the spacing between sections
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 25
//    }
    
    // Make the background color show through
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
//        return headerView
//    }
    
    
    /**
     Defines how cell should look like
     
     :param:
     
     :returns: cell
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! GameCell
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 160
    }

    
}

