//
//  WordFrequency.swift
//  Just the Facts Please
//
//  Created by Alex Makedonski on 9/10/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation

struct WordFrequency<T:Tokenizable>: Comparable,CustomStringConvertible{
    
    static func < (lhs: WordFrequency, rhs: WordFrequency) -> Bool {
        return lhs.frequency < rhs.frequency
    }
    
    
    let tokenizable: T
    let frequency: Int
    
    var description: String{
        return "\(tokenizable.wordToken):\(frequency)"
    }
}
