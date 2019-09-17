//
//  POSTagger.swift
//  BigramTagger
//
//  Created by Alex Makedonski on 9/17/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation
import NaturalLanguage

class POSTagger{
    
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
    
    
    func getTaggedWords() -> [TaggedWord]{
        
        var taggedWords = [TaggedWord]()
        
        var index = 0
        
        self.tagger.enumerateTags(in: fullTextRange, unit: .word, scheme: .nameTypeOrLexicalClass, options: .omitWhitespace, using: {
            tag, tokenRange in
            
            if let tag = tag,let word = text.getSubString(fromRange: tokenRange){
                
                var taggedWord = TaggedWord(word: word, tag: tag)
                taggedWord.wordPosition = index
                
                taggedWords.append(taggedWord)
                index += 1
                

            }
            return true
        })
        
        return taggedWords
    }
    
}
