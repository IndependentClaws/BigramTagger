//
//  WordLemma.swift
//  BigramTagger
//
//  Created by Alex Makedonski on 9/17/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation

struct WordLemma: Tokenizable, CustomStringConvertible{
    
    var lemma: String
    var inflectedForm: String?
    
    var wordToken: String{
        return lemma
    }
    
    var description: String{
        return "Lemma: \(lemma), Inflected Form: \(inflectedForm ?? "Not Available")"
    }
}
