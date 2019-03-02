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
    
    // Objects needed
    let contentCell = UIView()
    let iconAway = UIImageView()
    let iconHome = UIImageView()
    let scoreExcitement = UILabel()
    let teamNameAway = UILabel()
    let teamNameHome = UILabel()
    let arenaName = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIView()
        setupUIImageView()
        setupLabels()
        setupCellView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Sets up styles of Cell
    func setupUIView() {
        contentCell.backgroundColor = UIColor(red: 254/255, green: 255/255, blue: 254/255, alpha: 1)
        contentCell.layer.cornerRadius = 15
        contentCell.layer.borderWidth = 1
        contentCell.layer.borderColor = UIColor(red: 231/255, green: 233/255, blue: 237/255, alpha: 1).cgColor
    }
    
    // Sets up styles of ImageViews
    func setupUIImageView() {
        iconAway.backgroundColor = .white
        iconHome.backgroundColor = .white
    }
    
    // Sets up styles of Labels
    func setupLabels() {
        scoreExcitement.font = UIFont(name: "OpenSans-Bold", size: 25)
        scoreExcitement.text = "10.0"
        scoreExcitement.textAlignment = .center
        teamNameAway.font = UIFont(name: "OpenSans-Bold", size: 20)
        teamNameHome.font = UIFont(name: "OpenSans-Bold", size: 20)
        arenaName.font = UIFont(name: "OpenSans-Bold", size: 15)
    }
    
    // Sets up cell View and add constraints to all elements
    func setupCellView() {
        
        // Add subview to cell contentView
        contentCell.addSubview(iconAway)
        contentCell.addSubview(iconHome)
        contentCell.addSubview(scoreExcitement)
        contentCell.addSubview(teamNameAway)
        contentCell.addSubview(teamNameHome)
        contentCell.addSubview(arenaName)
        self.contentView.addSubview(contentCell)
        
        // Enables constraints for labels
        iconAway.translatesAutoresizingMaskIntoConstraints = false
        iconHome.translatesAutoresizingMaskIntoConstraints = false
        scoreExcitement.translatesAutoresizingMaskIntoConstraints = false
        teamNameAway.translatesAutoresizingMaskIntoConstraints = false
        teamNameHome.translatesAutoresizingMaskIntoConstraints = false
        arenaName.translatesAutoresizingMaskIntoConstraints = false
        contentCell.translatesAutoresizingMaskIntoConstraints = false
        
        // Activate constraints
        NSLayoutConstraint.activate([
            
            // Creats content with margin to cell borders
            contentCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            contentCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            // Away Team Constraints
            iconAway.widthAnchor.constraint(equalToConstant: 50),
            iconAway.heightAnchor.constraint(equalToConstant: 50),
            iconAway.leadingAnchor.constraint(equalTo: contentCell.leadingAnchor, constant: 25),
            iconAway.topAnchor.constraint(equalTo: arenaName.bottomAnchor, constant: 5),
            teamNameAway.topAnchor.constraint(equalTo: iconAway.bottomAnchor, constant: 5),
            teamNameAway.centerXAnchor.constraint(equalTo: iconAway.centerXAnchor),

            // Home Team Constraints
            iconHome.widthAnchor.constraint(equalToConstant: 50),
            iconHome.heightAnchor.constraint(equalToConstant: 50),
            iconHome.trailingAnchor.constraint(equalTo: contentCell.trailingAnchor, constant: -25),
            iconHome.topAnchor.constraint(equalTo: arenaName.bottomAnchor, constant: 5),
            teamNameHome.topAnchor.constraint(equalTo: iconHome.bottomAnchor, constant: 5),
            teamNameHome.centerXAnchor.constraint(equalTo: iconHome.centerXAnchor),

            // Score Constraints
            scoreExcitement.widthAnchor.constraint(equalToConstant: 80),
            scoreExcitement.centerXAnchor.constraint(equalTo: contentCell.centerXAnchor),
            scoreExcitement.centerYAnchor.constraint(equalTo: contentCell.centerYAnchor),
            
            // Arena Constraints
            arenaName.topAnchor.constraint(equalTo: contentCell.topAnchor, constant: 10),
            arenaName.centerXAnchor.constraint(equalTo: contentCell.centerXAnchor)

            ])

    }
    
}
