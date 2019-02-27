//
//  GameCell.swift
//  NBAScorer
//
//  Created by Jonas Kübler on 22.02.19.
//  Copyright © 2019 Jonas.K. All rights reserved.
//

import Foundation
import UIKit


class GameCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let contentCell: UIView = {
        let cellView = UIView()
        cellView.backgroundColor = UIColor(red: 254/255, green: 255/255, blue: 254/255, alpha: 1)
        cellView.layer.cornerRadius = 15
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor(red: 231/255, green: 233/255, blue: 237/255, alpha: 1).cgColor
        return cellView
        
    }()
    
    // ImageView for away icon
    let iconAway: UIImageView = {
        let imageViewAway = UIImageView()
        //imageViewAway.image = UIImage(named: "hawks.png")!
        imageViewAway.backgroundColor = .green
        return imageViewAway
    }()
    
    // ImageView for home icon
    let iconHome: UIImageView = {
        let imageViewHome = UIImageView()
        //imageViewHome.image = UIImage(named: "hawks.png")!
        imageViewHome.backgroundColor = .black
        return imageViewHome
    }()
    
    // Excitement Score Label
    let scoreExcitement: UILabel = {
        let exScoreLabel = UILabel()
        exScoreLabel.text = "9.8"
        exScoreLabel.font = exScoreLabel.font.withSize(30)
        exScoreLabel.font = UIFont.boldSystemFont(ofSize: exScoreLabel.font.pointSize)
        exScoreLabel.font = UIFont(name: "OpenSans-Bold", size: 25)
        //exScoreLabel.backgroundColor = .blue
        exScoreLabel.textAlignment = .center
        return exScoreLabel
    }()
    
    let teamNameAway: UILabel = {
        let awayTeamLabel = UILabel()
        awayTeamLabel.text = "AWY"
        awayTeamLabel.font = awayTeamLabel.font.withSize(30)
        awayTeamLabel.font = UIFont.boldSystemFont(ofSize: awayTeamLabel.font.pointSize)
        awayTeamLabel.font = UIFont(name: "OpenSans-Bold", size: 20)
        return awayTeamLabel
    }()
    
    let teamNameHome: UILabel = {
        let homeTeamLabel = UILabel()
        homeTeamLabel.text = "HME"
        homeTeamLabel.font = homeTeamLabel.font.withSize(30)
        homeTeamLabel.font = UIFont.boldSystemFont(ofSize: homeTeamLabel.font.pointSize)
        homeTeamLabel.font = UIFont(name: "OpenSans-Bold", size: 20)
        return homeTeamLabel
    }()
    
    let arenaName: UILabel = {
        let arenaLabel = UILabel()
        arenaLabel.text = "Arena"
        arenaLabel.font = arenaLabel.font.withSize(30)
        arenaLabel.font = UIFont.boldSystemFont(ofSize: arenaLabel.font.pointSize)
        arenaLabel.font = UIFont(name: "OpenSans-Bold", size: 15)
        return arenaLabel
    }()
    
    //    let scoreAway: UILabel = {
    //        let awayScoreLabel = UILabel()
    //        awayScoreLabel.text = "125"
    //        awayScoreLabel.font = awayScoreLabel.font.withSize(25)
    //        awayScoreLabel.font = UIFont.boldSystemFont(ofSize: awayScoreLabel.font.pointSize)
    //        awayScoreLabel.backgroundColor = .blue
    //        awayScoreLabel.textAlignment = .center
    //        return awayScoreLabel
    //    }()
    //
    //    let scoreHome: UILabel = {
    //        let homeScoreLabel = UILabel()
    //        homeScoreLabel.text = "97"
    //        homeScoreLabel.font = homeScoreLabel.font.withSize(25)
    //        homeScoreLabel.font = UIFont.boldSystemFont(ofSize: homeScoreLabel.font.pointSize)
    //        homeScoreLabel.backgroundColor = .blue
    //        homeScoreLabel.textAlignment = .center
    //        return homeScoreLabel
    //    }()
    //
    //    let separator: UILabel = {
    //        let separatorLabel = UILabel()
    //        separatorLabel.backgroundColor = .red
    //        separatorLabel.text = "-"
    //        separatorLabel.font = separatorLabel.font.withSize(25)
    //        separatorLabel.font = UIFont.boldSystemFont(ofSize: separatorLabel.font.pointSize)
    //        separatorLabel.textAlignment = .center
    //        return separatorLabel
    //    }()
    
    func setupCellView() {
        
        // Add subview to cell contentView
        contentCell.addSubview(iconAway)
        contentCell.addSubview(iconHome)
        contentCell.addSubview(scoreExcitement)
        contentCell.addSubview(teamNameAway)
        contentCell.addSubview(teamNameHome)
        contentCell.addSubview(arenaName)
        self.contentView.addSubview(contentCell)
        //        self.contentView.addSubview(scoreAway)
        //        self.contentView.addSubview(scoreHome)
        //        self.contentView.addSubview(separator)
        
        
        // Enables constraints for labels
        iconAway.translatesAutoresizingMaskIntoConstraints = false
        iconHome.translatesAutoresizingMaskIntoConstraints = false
        scoreExcitement.translatesAutoresizingMaskIntoConstraints = false
        teamNameAway.translatesAutoresizingMaskIntoConstraints = false
        teamNameHome.translatesAutoresizingMaskIntoConstraints = false
        arenaName.translatesAutoresizingMaskIntoConstraints = false
        contentCell.translatesAutoresizingMaskIntoConstraints = false
        //        scoreAway.translatesAutoresizingMaskIntoConstraints = false
        //        scoreHome.translatesAutoresizingMaskIntoConstraints = false
        //        separator.translatesAutoresizingMaskIntoConstraints = false
        
     
        
        NSLayoutConstraint.activate([
            
            // Creats content with margin to cell borders
            contentCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            contentCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            // Away Team Constraints
            iconAway.widthAnchor.constraint(equalToConstant: 64),
            iconAway.heightAnchor.constraint(equalToConstant: 64),
            iconAway.leadingAnchor.constraint(equalTo: contentCell.leadingAnchor, constant: 25),
            iconAway.centerYAnchor.constraint(equalTo: contentCell.centerYAnchor),
            teamNameAway.topAnchor.constraint(equalTo: iconAway.bottomAnchor, constant: 5),
            teamNameAway.centerXAnchor.constraint(equalTo: iconAway.centerXAnchor),

            // Home Team Constraints
            iconHome.widthAnchor.constraint(equalToConstant: 64),
            iconHome.heightAnchor.constraint(equalToConstant: 64),
            iconHome.trailingAnchor.constraint(equalTo: contentCell.trailingAnchor, constant: -25),
            iconHome.centerYAnchor.constraint(equalTo: contentCell.centerYAnchor),
            teamNameHome.topAnchor.constraint(equalTo: iconHome.bottomAnchor, constant: 5),
            teamNameHome.centerXAnchor.constraint(equalTo: iconHome.centerXAnchor),

            // Score Constraints
            scoreExcitement.widthAnchor.constraint(equalToConstant: 80),
            scoreExcitement.centerXAnchor.constraint(equalTo: contentCell.centerXAnchor),
            scoreExcitement.centerYAnchor.constraint(equalTo: contentCell.centerYAnchor),
            
            // Arena Constraints
            arenaName.topAnchor.constraint(equalTo: contentCell.topAnchor, constant: 10),
            arenaName.centerXAnchor.constraint(equalTo: contentCell.centerXAnchor)
            
            

            //            scoreAway.widthAnchor.constraint(equalToConstant: 64),
            //            scoreAway.heightAnchor.constraint(equalToConstant: 35),
            //            scoreAway.leadingAnchor.constraint(equalTo: iconAway.trailingAnchor, constant: 25),
            //            scoreAway.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            //            scoreHome.widthAnchor.constraint(equalToConstant: 64),
            //            scoreHome.heightAnchor.constraint(equalToConstant: 35),
            //            scoreHome.trailingAnchor.constraint(equalTo: iconHome.leadingAnchor, constant: -25),
            //            scoreHome.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            //            separator.widthAnchor.constraint(equalToConstant: 10),
            //            separator.heightAnchor.constraint(equalToConstant: 10),
            //            separator.leadingAnchor.constraint(equalTo: scoreAway.trailingAnchor, constant: 5),
            //            separator.centerYAnchor.constraint(equalTo: self.centerYAnchor)

            ])

    }
    
}
