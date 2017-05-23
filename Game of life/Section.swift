//
//  Section.swift
//  Game of Life
//
//  Created by Dan Beaulieu on 12/20/15.
//  Copyright © 2015 Dan Beaulieu. All rights reserved.
//

import Foundation

struct Section<T> {

    var header : String
    var items : [T]
    
    init(header: String, _ items: [T]) {
        self.header = header
        self.items = items
    }
}
