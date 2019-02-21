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
    
    static let instance = Requests()
    
    func getTodaysData(completionHandler: @escaping (_ result : NSDictionary) -> ()) {
        
        // User credential for my sportsfeed
        let credential = URLCredential(user: "37589a6c-8217-4b96-8b06-e1ecf8", password: "joni1992", persistence: .forSession)
     
        // Make request
        AF.request("https://api.mysportsfeeds.com/v1.2/pull/nba/2018-2019-regular/game_boxscore.json?gameid=20190213-PHI-NYK")
            .authenticate(with: credential)
            .responseJSON { response in
                
                // Send error message if data can't be fetched
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200:
                        print("Data successful fetched")
                    default:
                        print("Error with response status: \(status)")
                    }
                }
                
                //to get JSON return value
                if let result = response.result.value {
                    completionHandler(result as! NSDictionary)
                    return
                }
        }
    }
    
}
