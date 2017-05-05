//
//  GameBoard.swift
//  Game of life
//
//  Created by Josman Pérez Expósito on 25/04/2017.
//  Copyright © 2017 Josman Pérez Expósito. All rights reserved.
//

import UIKit

class GameBoard: UIView {
    
    let life: Life
    
    init(createdLife: Life) {
        life = createdLife
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 0)))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let currentContext = UIGraphicsGetCurrentContext()
        
        for cell in life.cells {
            if let currentContext = currentContext {
                currentContext.setFillColor(colorForCell(cell.state).cgColor)
                currentContext.addRect(frameForCell(cell: cell))
                currentContext.fillPath()
            }
        }
    }
    
    func colorForCell(_ state: State) -> UIColor {
        switch state {
        case .Living:
            return UIColor(red: 54/255, green: 127/255, blue: 255/255, alpha: 1.0)
        case .Dead:
            return UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1.0)
        case .PreBirth:
            return UIColor(red: 0/255, green: 56/255, blue: 153/255, alpha: 1.0)
        }
    }
    
    func frameForCell(cell: Cell) -> CGRect {
        let dimensions = CGFloat(self.life.gridSize)
        let cellSize = CGSize(width: self.bounds.width/dimensions, height: self.bounds.height/dimensions)
        return CGRect(x: CGFloat(cell.xCoord) * cellSize.width, y: CGFloat(cell.yCoord) * cellSize.height, width: cellSize.width, height: cellSize.height)
    }
}
