//
//  BigramTagger.swift
//  BigramTagger
//
//  Created by Alex Makedonski on 9/16/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation
import NaturalLanguage

class BigramTagger{
    
    
    private var bigramTaggerDelegate: BigramTaggerDelegate?
    
    private var bigrams = [[TaggedWord]]()
    
    init(delegate: BigramTaggerDelegate?) {
        self.bigramTaggerDelegate = delegate ?? self
    }
    
    
    
    func tagBigrams(forText text: String){
        
        guard let delegate = bigramTaggerDelegate else {
            print("Please set a bigram tagger delegate")
            return
            
        }
        
        if !bigrams.isEmpty { self.bigrams = [[TaggedWord]]() }
        
        
        let tagTypes: [NLTag] = [.noun,.adverb,.adjective,
                                 .verb,.pronoun,.preposition,.conjunction,
                                 .determiner,.preposition,.number,.other,.otherWord]
        
        
        delegate.didStartParsingBigrams()
        
        let tagger = NLTagger(tagSchemes: [NLTagScheme.lexicalClass])
        
        tagger.string = text
        
        var currentNGram: TaggedWord?
        var previousNGram: TaggedWord?
        
        
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: NLTokenUnit.word, scheme: .lexicalClass, options:NLTagger.Options.omitWhitespace){
            tag, tokenRange in
            
            if let tag = tag,tagTypes.contains(tag){
                
                
                let word = String(text[tokenRange])
                
                currentNGram = TaggedWord(word: word, tag: tag)
             
                defer{
                    previousNGram = currentNGram
                }
                
                delegate.didFindBigram(withCurrentNGram: currentNGram, andWithPreviousNGram: previousNGram)
                
                if let previousNGram = previousNGram, let currentNGram = currentNGram{
                    bigrams.append([previousNGram,currentNGram])

                }
            
            }
            
            
            return true
        }
        
        delegate.didFinishParsingBigrams(withBigrams: self.bigrams)

        
        
    }
}

extension BigramTagger:BigramTaggerDelegate{
    internal func didStartParsingBigrams() {
        print("Started parsing bigrams...")
    }
    
    internal func didFindBigram(withCurrentNGram currentNGram: TaggedWord?, andWithPreviousNGram previousNGram: TaggedWord?) {
        
        if let currentNGram = currentNGram,let previousNGram = previousNGram{
            
            print("Adding bigram: \(previousNGram) \(currentNGram)")
            bigrams.append([previousNGram,currentNGram])
        }
        
    }
    
    internal func didFinishParsingBigrams(withBigrams bigrams: [[TaggedWord]]) {
        print("Finished parsing bigrams...")
        
        
        print("Total bigrams found: \(bigrams.count)")
    }
    
    

    
}


