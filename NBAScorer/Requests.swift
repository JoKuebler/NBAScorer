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
    
    func getTodaysData() {
        
        let credential = URLCredential(user: "37589a6c-8217-4b96-8b06-e1ecf8", password: "joni1992", persistence: .forSession)
     
        AF.request("https://api.mysportsfeeds.com/v1.2/pull/nba/2018-2019-regular/game_boxscore.json?gameid=20190211-NYK-CLE")
            .authenticate(with: credential)
            .responseJSON { response in
                debugPrint(response)
        }
        
    }
    
}
