//
//  SimpleBigramTagger.swift
//  BigramTagger
//
//  Created by Alex Makedonski on 9/17/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//


import Foundation
import NaturalLanguage

class SimpleNGramTagger{
    
    typealias Bigram = (n1: TaggedWord, n2: TaggedWord)
    typealias Trigram = (n1: TaggedWord,n2:TaggedWord,n3:TaggedWord)
    
    //The class can be initialized with a text, in which case the text will automatically be tagged with parts of speech and lexical class information
    init(withText text: String) {
        
        self.taggedWords = SimpleNGramTagger.GetTaggedWords(fromText: text)
    }
    
    //The class can be initialized directly with a set of word tokens that have already been tagged
    private var taggedWords: [TaggedWord]
    
    init(withTaggedWords taggedWords: [TaggedWord]) {
        self.taggedWords = taggedWords
    }
    
    func numberOfBigrams(withTagPattern tagPattern: [NLTag]) -> Int{
        guard tagPattern.count == 2 else { return 0 }
        
        let bigrams = getBigrams()
        
        return bigrams.filter{ $0.n1.tag == tagPattern.first! && $0.n2.tag == tagPattern.last! }.count
    }
    
    func numberOfTrigrams(withTagPattern tagPattern: [NLTag]) -> Int{
        guard tagPattern.count == 3 else { return 0 }
        
        let trigrams = getTrigrams()
        
        return trigrams.filter{ $0.n1.tag == tagPattern.first! && $0.n2.tag == tagPattern[1] && $0.n3.tag == tagPattern.last! }.count

    }
    
    func getTrigrams() -> [Trigram]{
        var trigrams: [Trigram] = []
        
        for idx in 0..<taggedWords.count where idx+2<taggedWords.count{
            let n1 = taggedWords[idx]
            let n2 = taggedWords[idx+1]
            let n3 = taggedWords[idx+2]

            
            trigrams.append(Trigram(n1:n1, n2:n2, n3:n3))
            
        }
        
        return trigrams
    }
    
    func getBigrams() -> [Bigram]{
        
        var bigrams: [Bigram] = []
        
        for idx in 0..<taggedWords.count where idx+1<taggedWords.count{
            let n1 = taggedWords[idx]
            let n2 = taggedWords[idx+1]
            
            bigrams.append(Bigram(n1: n1,n2:n2))
            
        }
        
        return bigrams
    }
    
    
}

extension SimpleNGramTagger{
    
    private static func GetTaggedWords(fromText text: String) -> [TaggedWord]{
        
        var taggedWords = [TaggedWord]()
        
        let tagger = NLTagger(tagSchemes: [.nameTypeOrLexicalClass])
        tagger.string = text
        
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .nameTypeOrLexicalClass, options: .omitWhitespace, using: {
            tag, tokenRange in
            
            if let tag = tag,let word = text.getSubString(fromRange: tokenRange){
                
                let taggedWord = TaggedWord(word: word, tag: tag)
                taggedWords.append(taggedWord)
            }
            return true
        })
        
        return taggedWords
    }
}
