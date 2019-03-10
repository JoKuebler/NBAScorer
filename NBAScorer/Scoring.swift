//
//  Scoring.swift
//  NBAScorer
//
//  Created by Jonas Kübler on 09.03.19.
//  Copyright © 2019 Jonas.K. All rights reserved.
//

import SwiftyJSON

class Scoring {
    
    // Instace to make calls in ViewController
    static let instance = Scoring()
    
    /**
     Calculates Team Score of Excitement Score
     
     :param: scoreboardJson
     
     :returns: teamDiffScore
     */
    func calculateTeamScore(scoreBoardJson: JSON) -> Double {
        
        let awayScore = scoreBoardJson["awayScore"].intValue
        let homeScore = scoreBoardJson["homeScore"].intValue
        var teamDiffScore = 0.0
        
        switch abs(awayScore - homeScore) {
        case 0...4:
            teamDiffScore = 1.0
        case 4:
            teamDiffScore = 2.0
        case 4...7:
            teamDiffScore = 3.0
        case 7...10:
            teamDiffScore = 4.0
        case 10...15:
            teamDiffScore = 5.0
        default:
            teamDiffScore = 6.0
        }
        
        return teamDiffScore
    }
    
    
    /**
     Calculates Team Standing of Excitement Score
     
     :param: scoreboardJson
     
     :returns: teamStandScore
     */
    func calculateTeamStandScore(standingJson: JSON) -> Double {
        
        let easternStandings = standingJson["conferenceteamstandings"]["conference"]
        let westernStandings = standingJson["conferenceteamstandings"]["conference"]
        
        var teamStandScore = 0.0
        
        return teamStandScore
    }
    
}
