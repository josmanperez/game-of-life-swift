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
    @IBOutlet var menuButton: UIBarButtonItem!
    
    var life = Life()
    let gameBoard:GameBoard
    
    var timer: Timer!
    
    
    required init?(coder aDecoder: NSCoder) {
        gameBoard = GameBoard(createdLife: life)
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameBoard.frame = boardView.frame
        gameBoard.center = CGPoint(x: gameBoard.frame.size.width / 2, y: gameBoard.frame.size.height / 2)
        boardView.addSubview(gameBoard)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.startTimer(recognizer:)))
        boardView.addGestureRecognizer(tap)
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = 200
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer(recognizer: UIGestureRecognizer) -> Void {
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(ViewController.moment), userInfo: nil, repeats: true)
        
    }

    func initializeGame() {
        life.cells.forEach {
            $0.state = State.randomState()
        }
    }
    
    func moment() {
        life.evolve()
        gameBoard.setNeedsDisplay()
    }

    @IBAction func handleResetButtonTap(_ sender: Any) {
        timer.invalidate()
        initializeGame()
        gameBoard.setNeedsDisplay()
    }
    
}

