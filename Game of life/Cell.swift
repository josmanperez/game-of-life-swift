//
//  Cell.swift
//  Game of life
//
//  Created by Josman Pérez Expósito on 25/04/2017.
//  Copyright © 2017 Josman Pérez Expósito. All rights reserved.
//

import Foundation

class Cell {
    let xCoord: Int
    let yCoord: Int
    var state: State
    
    init(x: Int, y: Int) {
        self.xCoord = x
        self.yCoord = y
        self.state = State.randomState()
    }
}
