//
//  String+Extensions.swift
//  BigramTagger
//
//  Created by Alex Makedonski on 9/17/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation
import NaturalLanguage

extension String{
    
    typealias Bigram = (n1: TaggedWord,n2:TaggedWord)
    typealias Trigram = (n1: TaggedWord,n2:TaggedWord,n3:TaggedWord)
    
    //MARK ********************************

    
    func getTrigrams(withTagPattern tagPattern: [NLTag]) -> [Trigram]{
        
        guard tagPattern.count == 3 else { return [] }
        
        let tagger = SimpleNGramTagger(withText: self)
       
        return tagger.getTrigrams().filter{
            $0.n1.tag == tagPattern.first! && $0.n2.tag == tagPattern[1] && $0.n3.tag == tagPattern.last!
        }
        
    }


    func getBigrams(withTagPattern tagPattern: [NLTag]) -> [Bigram]{
        
        guard tagPattern.count == 2 else { return [] }
        
        let tagger = SimpleNGramTagger(withText: self)
        
        return tagger.getBigrams().filter{
            $0.n1.tag == tagPattern.first! && $0.n2.tag == tagPattern.last!
        }
        
    }
    
    //MARK ********************************

    
    func getTrigrams() -> [Trigram]{
        let tagger = SimpleNGramTagger(withText: self)

        return tagger.getTrigrams()
    }
    
    func getBigrams() -> [Bigram]{
        let tagger = SimpleNGramTagger(withText: self)
        
        return tagger.getBigrams()
    }
    
    
    //MARK ********************************

    func toalNumberOfWords() -> Int{
        return self.tokenize().count
    }
    
    
    //MARK ********************************

    
    func numberOfAdjectives() -> Int{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isAdjective()}.count
    }
    

    func numberOfConjunctions() -> Int{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isConjunction()}.count
    }
    func numberOfPrepositions() -> Int{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isPreposition()}.count
    }
    
    func numberOfAdverbs() -> Int{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isAdverb()}.count
    }
    
    func numberOfIndirectObjectPronouns() -> Int{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isIndirectObjectPronoun()}.count
    }
    
    func numberOfDemonstrativePronouns() -> Int{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isDemonstrativePronoun()}.count
    }
    
    
    func numberOfDeterminers() -> Int{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isDeterminer()}.count
    }
    
    func numberOfGeneralNouns() -> Int{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isGeneralNoun()}.count
    }
    
    func numberOfNouns() -> Int{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isNoun()}.count
    }
    
    func numberOfVerbs() -> Int{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isVerb()}.count
    }
    
    
    func numberOfProperNouns() -> Int{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isProperNoun()}.count
    }
    
    func numberOfPronouns() -> Int{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isPronoun()}.count
    }
    
    //MARK ********************************
    
    func getAllWords(withTag tag: NLTag) -> [TaggedWord]{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.tag == tag}
    }
    func getAllConjunctions() -> [TaggedWord]{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isConjunction()}
    }
    
    func getAllPrepositions() -> [TaggedWord]{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isAdverb()}
    }
    func getAllAdverbs() -> [TaggedWord]{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isAdverb()}
    }
    
    func getAllIndirectObjectPronouns() -> [TaggedWord]{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isIndirectObjectPronoun()}
    }
    
    func getAllAdjectives() -> [TaggedWord]{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isAdjective()}
    }
    
    func getAllDemonstrativePronouns() -> [TaggedWord]{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isDemonstrativePronoun()}
    }
    
    func getAllDeterminers() -> [TaggedWord]{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isDeterminer()}
    }
    func getAllGeneralNouns() -> [TaggedWord]{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isGeneralNoun()}
    }
    
    func getAllNouns() -> [TaggedWord]{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isNoun()}
    }
    
    func getAllVerbs() -> [TaggedWord]{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isVerb()}
    }
    
    func getAllProperNouns() -> [TaggedWord]{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isProperNoun()}
    }
  
    func getAllPronouns() -> [TaggedWord]{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords().filter{$0.isPronoun()}
    }
    
    //MARK ********************************

    func lemmatize() -> [String]{
        let lemmatizer = LemmaTagger(sampleText: self)
        return lemmatizer.lemmatizeText()
    }
    
    //MARK ********************************

    func tagWithPartsOfSpeech() -> [TaggedWord]{
        let tagger = POSTagger(sampleText: self)
        return tagger.getTaggedWords()
    }
    
    //MARK ********************************

    func tokenize() -> [String]{
        let tokenizer = WordTokenizer(text: self)
        return tokenizer.parseAllWordTokens()
    }

    
    //MARK ********************************

    
    func getSubString(fromRange range: Range<String.Index>) -> String?{
    
            let (rangeLowerBound,rangeUpperBound) = (range.lowerBound,range.upperBound)
            
            let (startIndex,endIndex) = (self.startIndex,self.endIndex)
         
        if(rangeLowerBound >= startIndex && rangeUpperBound < endIndex){
            let subString = self[range]
            return String.init(subString)
        } else {
            return nil
        }
    
    }

}
