//
//  Utility.swift
//  Game of life
//
//  Created by Josman Pérez Expósito on 05/05/2017.
//  Copyright © 2017 Josman Pérez Expósito. All rights reserved.
//

import Foundation

extension Array {
//    func getNeighbors(predicate: (Cell) -> Bool) -> [Cell] {
//        var neighbors = [Cell]()
//        for item in self {
//            let cell = item as! Cell
//            if predicate(cell) {
//                neighbors.append(cell)
//            }
//        }
//        return neighbors
//    }
    
    func getNeighbors(predicate: (Element) -> Bool) -> [Element] {
        var filteredArray = [Element]()
        for x in self where predicate(x) {
            filteredArray.append(x)
        }
        return filteredArray
    }
    
}
