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
    var grid = (0...20)
    
    init() {
        cells = [Cell]()
        cells = assignCellsToGrid()
    }
    
    /**
     AssignCells creado usando for-in loop
    lazy var assignCellsToGrid:() -> [Cell] = {
        [weak self] in // Helps to avoid memory leaks
        var cells = [Cell]()
        for xLoc in 0..<self!.gridSize {
            for yLoc in 0..<self!.gridSize {
                cells.append(Cell(x: xLoc, y: yLoc))
            }
        }
        return cells
    }
    */
    
    /**
     AssignCell usando funciones de alto nivel (high order functions)
    */
    func assignCellsToGrid() -> [Cell] {
        return (0...20).flatMap{ x in (0...20).map { Cell(x: x, y: $0) } }
    }
    
    func evolve(completion: (_ remaining: Int) -> ()) {
        
        let liveCells = cells.filter { $0.state == State.Living }
        let deadCells = cells.filter { $0.state != State.Living }
        
        // Rules 1,2, & 3
        let dyingCells = liveCells.filter { !(2...3 ~= livingNeighbors(cell: $0)) }
        
        // Rule 4
        let newLife = deadCells.filter { livingNeighbors(cell: $0) == 3 }
        
        newLife.forEach { $0.state = .Living }
        dyingCells.forEach { $0.state = .Dead }
        
        if (liveCells.count < 40) {
            completion(liveCells.count)
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "passCountId"), object: liveCells.count)
        
    }
    
//    func cellNeighbors(cell: Cell) -> [Cell] {
//        var neigbors:[Cell] = []
//        for cell2 in cells {
//            
//            let check = cellAreNeighbors(sideA: cell, sideB: cell2)
//            if check {
//                neigbors.append(cell2)
//            }
//        }
//        return neigbors
//    }
    
    func cellNeighbors(cell: Cell) -> [Cell] {
        return self.cells.getNeighbors {
            self.cellAreNeighbors(sideA: cell, sideB: $0)
        }
    }
    
    func cellAreNeighbors(sideA: Cell, sideB: Cell) -> Bool {
        let a = abs(sideA.xCoord - sideB.xCoord)
        let b = abs(sideA.yCoord - sideB.yCoord)
        
        /* switch (a,b) {
         case (1,1), (1,0), (0,1):
         check = true
         default:
         check = false
         } */
        
        if case (0...1, 0...1) = (a,b), !(a == 0 && b == 0) { return true }
        else { return false }
        
    }
    
    func livingNeighbors(cell: Cell) -> Int {
        return cellNeighbors(cell: cell).filter { $0.state == .Living }.count
    }

}

