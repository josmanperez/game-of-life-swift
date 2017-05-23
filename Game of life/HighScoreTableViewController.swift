//
//  HighScoreTableViewController.swift
//  Game of Life
//
//  Created by Dan Beaulieu on 12/20/15.
//  Copyright © 2015 Dan Beaulieu. All rights reserved.
//

import UIKit

class HighScoreTableViewController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    var indicator = UIActivityIndicatorView()

    var scores = [Score]() {
        didSet {
           let mainQueue = OperationQueue.main
           mainQueue.addOperation() {
                self.tableView.reloadData()
           }
            
        }
    
    }
    
    func getScores() {
    
        self.indicator.startAnimating()
        self.indicator.backgroundColor = UIColor.white
    

        Connect().getAllScores { (result) -> () in
            
                let scoreData = result as! [AnyObject]
            
                scoreData.forEach { item in
                    self.scores.append(Score(name: item["UserName"] as! String, score: item["Moves"] as! Int))
              }
        
       
            self.indicator.stopAnimating()
            self.indicator.hidesWhenStopped = true
        }
            
    } 
        
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.getScores()

            if self.revealViewController() != nil {
         
                self.menuButton.target = self.revealViewController()
                self.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                
                // Uncomment to change the width of menu
                self.revealViewController().rearViewRevealWidth = 200
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (scores.count) 
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath as IndexPath)
        
        cell.textLabel!.text = scores[indexPath.row].name
        cell.detailTextLabel!.text = "\(scores[indexPath.row].score)"
        return cell
    }

}
