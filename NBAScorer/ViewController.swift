//
//  ViewController.swift
//  FirstApp
//
//  Created by Jonas Kübler on 03.02.19.
//  Copyright © 2019 Jonas.K. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

// This is how you get managed context to store persistent data in CoreData
let appDelegate = UIApplication.shared.delegate as! AppDelegate

var gameData: [GameData] = []

class ViewController: UITableViewController {
    
    // Count of games to determine table rows
    var lastGamesCount = 0
    var scoreBoardResult = JSON()
    var teamStandingResult = JSON()
    var teamScore = 0.0
    var standingScore = 0.0
    
    // Today
    let currentDate = Date()
    let calendar = Calendar.current
    // Converts date in desired format
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())
        dateFormatter.dateFormat = "yyyyMMdd"
        let yesterdayString = dateFormatter.string(from: yesterday!)
        // Set Navigation Bar Title and make it bigger
        navigationItem.title = "Last Night's Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Fetch Core Data to determine if new API Call is necessary
        self.fetch { (complete) in
            if complete {
                
                // If CoreData already was saved before and is not empty check if it is the latest
                if gameData.count > 0 {

                    
                    // if the date if old and not from last night get new data
                    if gameData[0].date! != yesterdayString {

                        let alert = UIAlertController(title: "OLD DATE SO NEW API CALL", message: "CORE DATA SIZE: \(gameData.count), DATE: \(yesterdayString), STORED DATE: \(gameData[0].date!)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        // remove the old one
                        self.removeGoal(index: 0)
                        
                        // make API Call to get data
                        self.makeNewApiCall(yesterdayString: yesterdayString)
                        
                    } else {
                    
                        let alert = UIAlertController(title: "SAME DATE SO USE CORE DATA", message: "CORE DATA SIZE: \(gameData.count), DATE: \(yesterdayString), STORED DATE: \(gameData[0].date!)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        
                        self.scoreBoardResult = JSON.init(parseJSON: gameData[0].scoreBoard!)
                        self.lastGamesCount = Int(gameData[0].gamesCount!)!
                        
                    }
                } else {
                    let alert = UIAlertController(title: "CORE DATA EMPTY SO STORE IT", message: "CORE DATA SIZE: \(gameData.count), DATE: \(yesterdayString)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    // make API Call to get data
                    self.makeNewApiCall(yesterdayString: yesterdayString)
                }
            }
        }
        
        //        Requests.instance.getTeamStandings { (teamStandings) in
        //
        //            self.teamStandingResult = JSON(teamStandings)
        //
        //            // Reload TableView when Data is ready
        //            self.tableView.reloadData()
        //
        //        }
        
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
    
    
    func makeNewApiCall(yesterdayString: String) {
        
        // make API Call to get data
        Requests.instance.getScoreBoard(yesterdayString: yesterdayString) { (lastNightGames) in
            
            // Easy access with SwiftyJSON
            self.scoreBoardResult = JSON(lastNightGames)
            // Count amount of games
            self.lastGamesCount = self.scoreBoardResult["games"].count
            
            // Save current Data
            self.save(yesterdayStringParam: yesterdayString, gamesCountParam: String(self.lastGamesCount), scoreBoardParam: self.scoreBoardResult) { (complete) in
                print("Saved new Core Data")
            }
            
            // Reload TableView when Data is ready
            self.tableView.reloadData()
        }
        
    }
    
    
    func save(yesterdayStringParam: String, gamesCountParam: String, scoreBoardParam: JSON, completion: (_ finished: Bool) -> ()) {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let gameData = GameData(context: managedContext)
        
        gameData.date = yesterdayStringParam
        gameData.gamesCount = gamesCountParam
        gameData.scoreBoard = scoreBoardParam.rawString()!
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<GameData>(entityName: "GameData")
        
        do {
            gameData = try managedContext.fetch(fetchRequest)
            print("Successfully fetched data.")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func removeGoal(index: Int) {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(gameData[index])
        
        do {
            try managedContext.save()
            print("Successfully removed goal!")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
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
        
        //print("CALLED")
        
        // Get and style GameCell: No grey background on touch and Change backgroundcolor of cells
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.instance.cellID) as! GameCell
        cell.selectionStyle = .none
        cell.contentView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        
        //print(type(of: self.scoreBoardResult))
        // Get daily Game Entries
        let gameEntries = self.scoreBoardResult["games"]
        
        //print(gameEntries)
        
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

