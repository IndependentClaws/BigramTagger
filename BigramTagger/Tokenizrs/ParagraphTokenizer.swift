//
//  ParagraphTokenizer.swift
//  Just the Facts Please
//
//  Created by Alex Makedonski on 9/13/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation
import NaturalLanguage

class ParagraphTokenizer:BaseTokenizer{
    
    override var tokenUnit: NLTokenUnit{
        return NLTokenUnit.paragraph
    }
    
    
    func parseAllParagraphTokens() -> [String]{
        
        var paragraphTokens = [String]()
        
        parseAllTokens() {
            paragraphs in
            
            paragraphTokens.append(contentsOf: paragraphs)
        }
        
        return paragraphTokens
    }
    
    
    
}
