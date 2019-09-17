//
//  SimpleFrequency.swift
//  Just the Facts Please
//
//  Created by Alex Makedonski on 9/10/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation

/** The base class for all frequency distribution.  It provides information about total word count and total UNIQUE word count.  No sorting or normalization operations are performed by this class **/

class SimpleFrequencyDistribution<T> where T:Tokenizable{
    
    private var wordTokens: [T]
    
    private var wordFrequencyDict = [T:Int]()
    
    init(wordTokens: [T]) {
        self.wordTokens = wordTokens
        
        calculateTokenFrequencies()
    }
    
    func getAllHapaxLegomena() -> [T]{
        let wordFrequencies = getWordFrequencyArray()
        
        return wordFrequencies.filter{ $0.frequency == 1 }.map{$0.tokenizable}
    }
    
    func getWordVarietyCoefficient() -> Double{
        return Double(getTotalNumberOfUniqueWords())/Double(getTotalNumberOfWords())
        
    }

    
    /** Returns the total number of UNIQUE words i.e. word type.  As long as a given word occurs in the text, it only represens a single unique word for purposes of this function.   **/
    public func getTotalNumberOfUniqueWords() -> Int{
        return wordFrequencyDict.keys.count
    }
    
    
      /** Returns the total number count.  Each repetition of a single word type is counted in this value   **/
    public func getTotalNumberOfWords() -> Int{
        return wordTokens.count
    }
    
        public func getWordFrequencyArray() -> [WordFrequency<T>]{
        var kvArray = [WordFrequency<T>]()
        
        for (k,v) in getWordFrequencyDictionary(){
            kvArray.append(WordFrequency(tokenizable: k,frequency: v))
        }
        
        return kvArray
        
    }
    
    
      /** Returns the dictionary in which each word type is mapped to an integer representing the number of times it appears in the same text   **/
    public func getWordFrequencyDictionary() -> [T:Int]{
        return wordFrequencyDict
    }
    
    private func calculateTokenFrequencies(){
        
        for token in wordTokens{
            
            
            if let oldValue =  wordFrequencyDict[token]{
                wordFrequencyDict[token] = oldValue + 1
            } else {
                wordFrequencyDict[token] = 1
            }
        }
        
    }
}
