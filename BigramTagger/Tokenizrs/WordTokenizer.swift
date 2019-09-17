//
//  WordTokenizer.swift
//  Just the Facts Please
//
//  Created by Alex Makedonski on 9/13/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation
import NaturalLanguage

class WordTokenizer: BaseTokenizer{
    

    override var tokenUnit: NLTokenUnit{
        return super.tokenUnit
    }
    
    
    func parseAllWordTokens() -> [String]{
        
        var tokens = [String]()
        
        parseAllTokens() {
            words in
            
            tokens.append(contentsOf: words)
        }
        
        return tokens
    }
    
}
