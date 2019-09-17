//
//  BaseTokenizer.swift
//  Just the Facts Please
//
//  Created by Alex Makedonski on 9/13/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation
import NaturalLanguage

class BaseTokenizer{
    
 

    typealias TokenCompletionHandler = ([String])->Void

    //The initializer for our base class takes a sample text as an argument
    init(text: String) {
        self.text = text
    }
    
    //Computed helper property -- The token unit for initializing our tokenizer will be .word by default, but we can override this later
    var tokenUnit: NLTokenUnit{
        return NLTokenUnit.word
    }
    
    //A stored property for the text that we want to tokenize
    let text: String
    
  
    //Computed Helper Property -- The string.index range for the full sample text
     var fullTextRange: Range<String.Index>{
        return text.startIndex..<text.endIndex
    }
    
    //A lazily defined tokenizer allows us to instantiate an NLTokenizer that can be initialized with the sample text that we are tokenizing and the default NLToken units
    lazy var tokenizer: NLTokenizer = {
        let tokenizer = NLTokenizer(unit: self.tokenUnit)
        tokenizer.string = self.text
        return tokenizer
    }()
    
    func parseAllTokens(withCompletionHandler completion: TokenCompletionHandler){
        
        var tokens = [String]()
        
        self.tokenizer.enumerateTokens(in: self.fullTextRange, using: {
            
            tokenRange, _ in
            
            if let token = self.text.getSubString(fromRange: tokenRange){
                tokens.append(token)
                
            }
            return true
        })
        
        completion(tokens)
    }
}
