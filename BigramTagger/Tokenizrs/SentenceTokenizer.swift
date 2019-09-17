//
//  SentenceTokenizer.swift
//  Just the Facts Please
//
//  Created by Alex Makedonski on 9/13/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation
import NaturalLanguage

class SentenceTokenizer:BaseTokenizer{
    

    override var tokenUnit: NLTokenUnit{
        return NLTokenUnit.sentence
    }
    
    
    func parseAllSentenceTokens() -> [String]{
        
        var sentenceTokens = [String]()
        
        parseAllTokens(){
            sentences in
            
            sentenceTokens.append(contentsOf: sentences)
        }
        
        return sentenceTokens
        
    }
    
}
