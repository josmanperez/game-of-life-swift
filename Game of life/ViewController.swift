//
//  ViewController.swift
//  Game of life
//
//  Created by Josman Pérez Expósito on 25/04/2017.
//  Copyright © 2017 Josman Pérez Expósito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var boardView: UIView!
    
    var life = Life()
    let gameBoard:GameBoard
    
    
    required init?(coder aDecoder: NSCoder) {
        gameBoard = GameBoard(createdLife: life)
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameBoard.frame = boardView.frame
        gameBoard.center = CGPoint(x: gameBoard.frame.size.width / 2, y: gameBoard.frame.size.height / 2)
        boardView.addSubview(gameBoard)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

