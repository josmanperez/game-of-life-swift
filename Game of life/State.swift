//
//  State.swift
//  Game of life
//
//  Created by Josman Pérez Expósito on 25/04/2017.
//  Copyright © 2017 Josman Pérez Expósito. All rights reserved.
//

import Foundation

enum State: Int {
    case Living = 0, PreBirth, Dead
    
    static func randomState() -> State {
        guard let state = State(rawValue: Int(arc4random_uniform(2))) else {
            return .PreBirth
        }
        
        return state
    }
}
