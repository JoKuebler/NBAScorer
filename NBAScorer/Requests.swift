//
//  Requests.swift
//  FirstApp
//
//  Created by Jonas Kübler on 18.02.19.
//  Copyright © 2019 Jonas.K. All rights reserved.
//

import Foundation
import Alamofire


class Requests {
    
    // Instace to make calls in ViewController
    static let instance = Requests()
    // Today
    let currentDate = Date()
    let calendar = Calendar.current
    // Converts date in desired format
    let dateFormatter = DateFormatter()
    
    
    func makeRequest(apicall: String, completionHandlerParam: @escaping (_ result : NSDictionary) -> ()) {
        
        // User credential for my sportsfeed
        let credential = URLCredential(user: "5f9ea979-8a53-49d7-86b0-362c1b", password: "MYSPORTSFEEDS", persistence: .forSession)
        
        // Make request
        AF.request(apicall)
            .authenticate(with: credential)
            .responseJSON { response in
                
                // Send error message if data can't be fetched
                if let status = response.response?.statusCode {
                    switch(status) {
                    case 200:
                        print("Data successful fetched")
                    default:
                        print("Error with response status: \(status)")
                    }
                }
                
                //to get JSON return value
                if let result = response.result.value {
                    completionHandlerParam(result as! NSDictionary)
                    return
                }
        }
        
    }
    
    /**
     Sends an API request to scoreboard of todays gamres
     
     :param:
     
     :returns: No return value
     */
    func getScoreBoard(completionHandler: @escaping (_ result : NSDictionary) -> ()) {
        
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())
        dateFormatter.dateFormat = "yyyyMMdd"
        let yesterdayString = dateFormatter.string(from: yesterday!)
        
        self.makeRequest(apicall: "https://api.mysportsfeeds.com/v2.1/pull/nba/current/date/" + yesterdayString + "/games.json", completionHandlerParam: completionHandler)
    }
    
    /**
     Sends an API request to get current team standings
     
     :param:
     
     :returns: No return value
     */
    func getTeamStandings(completionHandler: @escaping (_ result : NSDictionary) -> ()) {
        
        self.makeRequest(apicall: "https://api.mysportsfeeds.com/v2.1/pull/nba/current/standings.json", completionHandlerParam: completionHandler)
    }
    
    
    
    
}
