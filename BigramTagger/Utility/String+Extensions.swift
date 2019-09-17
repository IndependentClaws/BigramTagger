//
//  String+Extensions.swift
//  BigramTagger
//
//  Created by Alex Makedonski on 9/17/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation
import NaturalLanguage

extension String: Tokenizable{
    
    var wordToken: String{
        return self
    }
    
    typealias Bigram = (n1: TaggedWord,n2:TaggedWord)
    typealias Trigram = (n1: TaggedWord,n2:TaggedWord,n3:TaggedWord)
    
    //MARK ********************************

    struct LinguisticInfo: Codable{
        let text: String
        let numberOfNouns: Int
        let numberOfVerbs: Int

    }
    
    //MARK ********************************
    
    func getTopNHighFrequencyWords(n: Int, ofTagType tag: NLTag) -> [String]{
      
        let taggedWords = self.getAllWords(withTag: tag)
        let freqDist = SortableFrequencyDistribution(wordTokens: taggedWords)
        return freqDist.topWordFrequencies(n: n).map{$0.tokenizable.wordToken}
        
    }
    
    func getBottomNLowFrequencyWords(n: Int, ofTagType tag: NLTag) -> [String]{
        
        let taggedWords = self.getAllWords(withTag: tag)
        let freqDist = SortableFrequencyDistribution(wordTokens: taggedWords)
        return freqDist.bottomWordFrequencies(n: n).map{$0.tokenizable.wordToken}
        
    }
    func getTopNHighFrequencyWords(n: Int) -> [String]{
        let tagger = POSTagger(sampleText: self)
        let taggedWords = tagger.getTaggedWords()
        
        let freqDist = SortableFrequencyDistribution(wordTokens: taggedWords)
        return freqDist.topWordFrequencies(n: n).map{$0.tokenizable.wordToken}
        
    }
    
    func getBottomNLowFrequencyWords(n: Int) -> [String]{
        let tagger = POSTagger(sampleText: self)
        let taggedWords = tagger.getTaggedWords()
        
        let freqDist = SortableFrequencyDistribution(wordTokens: taggedWords)
        return freqDist.topWordFrequencies(n: n).map{$0.tokenizable.wordToken}
        
    }
    
    func getAllHapaxLegomena(excludingTagTypes tagTypes: [NLTag]) -> [String]{
        let tagger = POSTagger(sampleText: self)
        let taggedWords = tagger.getTaggedWords()
        
        let freqDist = SimpleFrequencyDistribution(wordTokens: taggedWords)
        
        return freqDist.getAllHapaxLegomena().filter{!tagTypes.contains($0.tag)}.map{$0.wordToken}
    }
    
    func getAllHapaxLegomena(forTagType tagType: NLTag) -> [String]{
        let tagger = POSTagger(sampleText: self)
        let taggedWords = tagger.getTaggedWords()
        
        let freqDist = SimpleFrequencyDistribution(wordTokens: taggedWords)
        
        return freqDist.getAllHapaxLegomena().filter{$0.tag == tagType}.map{$0.wordToken}
        
    }
    func getAllHapaxLegomena() -> [String]{
        let tokens = self.tokenize()
        let freqDist = SimpleFrequencyDistribution(wordTokens: tokens)
        return freqDist.getAllHapaxLegomena()
        
    }
    //MARK ************************
    
    func getLinguisticInfo() -> LinguisticInfo{
        return LinguisticInfo(text: self, numberOfNouns: self.numberOfNouns(), numberOfVerbs: self.numberOfVerbs())
    }
    
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
