//
//  LemmaTagger.swift
//  Just the Facts Please
//
//  Created by Alex Makedonski on 9/13/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation

class LemmaTagger:BaseWordTagger{
    
    func lemmatizeText() -> [String]{
        return parseLemmas().map{$0.lemma}
    }
    
    func parseLemmas() -> [WordLemma]{
        
        var lemmas = [WordLemma]()
        
        
        self.tagger.enumerateTags(in: self.fullTextRange, unit: .word, scheme: .lemma, using: {
            tag, tokenRange in
            
            if let inflectedForm = self.text.getSubString(fromRange: tokenRange), let lemmatizedForm = tag?.rawValue{
                
                lemmas.append(WordLemma(lemma: lemmatizedForm, inflectedForm: inflectedForm))
            }
            
            return true
            
        })
        
        return lemmas
    }
    
    
    
}
