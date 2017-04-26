//
//  Life.swift
//  Game of life
//
//  Created by Josman Pérez Expósito on 25/04/2017.
//  Copyright © 2017 Josman Pérez Expósito. All rights reserved.
//

import Foundation

class Life {
    var cells: [Cell]
    var gridSize:Int = 20
    
    init() {
        cells = [Cell]()
        cells = assignCellsToGrid()
    }
    
    lazy var assignCellsToGrid:() -> [Cell] = {
        [weak self] in
        var cells = [Cell]()
        for xLoc in 0..<self!.gridSize {
            for yLoc in 0..<self!.gridSize {
                cells.append(Cell(x: xLoc, y: yLoc))
            }
        }
        return cells
    }
}
