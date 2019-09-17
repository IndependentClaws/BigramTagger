//
//  BaseTagger.swift
//  Just the Facts Please
//
//  Created by Alex Makedonski on 9/13/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation
import NaturalLanguage

class BaseWordTagger{
    
    
    init(sampleText: String) {
        self.text = sampleText
    }
    
    var text: String
    
    
    var fullTextRange: Range<String.Index>{
        return text.startIndex..<text.endIndex
    }
    
    
    private var availableTagSchemes: [NLTagScheme]{
        
        return [.lexicalClass,
                .lemma,
                .nameType,
                .nameTypeOrLexicalClass,
                .tokenType,
                .language]
    }
    
     var tokenUnit: NLTokenUnit{
        return NLTokenUnit.word
    }
    
    var options: NLTagger.Options{
        return [.omitWhitespace,.omitPunctuation]
    }
    
    
    
    lazy var tagger:NLTagger = {
        
        let tagger = NLTagger(tagSchemes: self.availableTagSchemes)
        tagger.string = self.text
        return tagger
    }()
    
    
    
}
