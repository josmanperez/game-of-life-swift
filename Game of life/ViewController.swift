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
    @IBOutlet var cellCountLabel: UILabel!
    @IBOutlet var resetButton: UIButton!
    
    var life = Life()
    let gameBoard:GameBoard
    
    var timer: Timer!
    var running = false
    var steps = 0
    
    required init?(coder aDecoder: NSCoder) {
        gameBoard = GameBoard(createdLife: life)
        super.init(coder: aDecoder)
        initializeGame()

    }
    
    convenience init() {
        self.init()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Connect.postNewScore()
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(passCount(notification:)), name: NSNotification.Name(rawValue: "passCountId"), object: nil)
        
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
//        life.evolve()
//        gameBoard.setNeedsDisplay()
        if running == false {
            self.resetButton.titleLabel!.text = "Stop"
            running = true
        }
        
        life.evolve { (remaining) -> () in
            let cellsLeft = remaining
            print(cellsLeft)
            self.endGame()
        }
        
        gameBoard.setNeedsDisplay() // instructs a redraw
    }
    
    func endGame() {
        steps = 0
        timer.invalidate()
        resetButton.titleLabel!.text = "Reset"
        resetButton.isEnabled = false
        running = false
        initializeGame()
        showAlert()
        
    }
    
    func passCount(notification: NSNotification) {
        guard let count = notification.object else {
            return
        }
        if (count as! Int) > 30 {
            steps = steps + 1
            cellCountLabel.text = "\(count)"
        } else {
            endGame()
        }

    }
    
    func configurationTextField(textField: UITextField!) {
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "\(self.steps) iterations", message: "Feel free to enter your desired name and press 'post' to add your score to the leaderboard.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (UIAlertAction) in
        }))
        self.present(alert, animated: true, completion: {
        })
    }
    
    // MARK: - Action for button

    @IBAction func handleResetButtonTap(_ sender: Any) {
//        timer.invalidate()
//        initializeGame()
//        gameBoard.setNeedsDisplay()
        if running == true {
            endGame()
        } else {
            resetButton.titleLabel!.text = "Stop"
        }
    }
    
}

