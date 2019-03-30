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
    
    func makeRequest(apicall: String, completionHandlerParam: @escaping (_ result : NSDictionary) -> ()) {
        
        
        // User credential for my sportsfeed
        // To prevent errors URL ProtectionSpace is neccessary
        let protectionSpace = URLProtectionSpace.init(host: "api.mysportsfeeds.com",
                                                      port: 443,
                                                      protocol: "https",
                                                      realm: nil,
                                                      authenticationMethod: nil)
        
        let userCredential = URLCredential(user: "5f9ea979-8a53-49d7-86b0-362c1b",
                                           password: "MYSPORTSFEEDS",
                                           persistence: .permanent)
        
        URLCredentialStorage.shared.setDefaultCredential(userCredential, for: protectionSpace)
        
        // Make request
        AF.request(apicall)
            .authenticate(with: userCredential)
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
    func getScoreBoard(yesterdayString: String, completionHandler: @escaping (_ result : NSDictionary) -> ()) {
        
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
