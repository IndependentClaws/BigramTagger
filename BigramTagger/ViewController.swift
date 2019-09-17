//
//  ViewController.swift
//  BigramTagger
//
//  Created by Alex Makedonski on 9/16/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import UIKit
import NaturalLanguage

class ViewController: UIViewController, BigramTaggerDelegate{
    
    func didStartParsingBigrams() {
        print("Started parsing bigrams...")
    }
    
    func didFindBigram(withCurrentNGram currentNGram: TaggedWord?, andWithPreviousNGram previousNGram: TaggedWord?) {
        
        if let currentNGram = currentNGram, let previousNGram = previousNGram{
            print("Did find bigram: \(previousNGram) \(currentNGram)")

        }
    }
    
    func didFinishParsingBigrams(withBigrams bigrams: [[TaggedWord]]) {
        print("Number of bigrams found: \(bigrams.count)")
        self.bigrams = bigrams
    }
    

    var bigrams = [[TaggedWord]](){
        didSet{
          showTrigramStatistics()
            
        }
    }
    
    func showTrigramStatistics(){
        
        let countDetAdjNoun = queryWordContext(middleTag: .adjective, previousTag: .determiner, nextTag: .noun)
        print("How many times did the pattern Det-Adj-Noun occur? \(countDetAdjNoun)")
   
        
        let countAdjAdjNoun = queryWordContext(middleTag: .adjective, previousTag: .adjective, nextTag: .noun)
        print("How many times did the pattern Adj-Adj-Noun occur? \(countAdjAdjNoun)")
    
        
        let countPrepDetNoun = queryWordContext(middleTag: .determiner, previousTag: .preposition, nextTag: .noun)
        print("How many times did the pattern Prep-Det-Noun occur? \(countPrepDetNoun)")
        
        let countVDetN = queryWordContext(middleTag: .determiner, previousTag: .verb, nextTag: .noun)
        print("How many times did the pattern Verb-Det-Noun occur? \(countVDetN)")
        
        
        let countNConjN = queryWordContext(middleTag: .conjunction, previousTag: .noun, nextTag: .noun)
        print("How many times did the pattern Noun-Conjunction-Noun occur? \(countNConjN)")

        
    }
    
    func showBigramStatistics(){
        print("All of the bigrams have been found!")
        
        print("How many times were nouns preceded by adjectives?")
        let countAdjN = queryBigramCount(previousTag: .adjective, nextTag: .noun)
        print("Frequency of adjective-noun pattern: \(countAdjN)")
        
        print("------------------------------------------------")
        
        print("How many times were nouns preceded by determiners?")
        let countDetN = queryBigramCount(previousTag: .determiner, nextTag: .noun)
        print("Frequency of determiner-noun pattern: \(countDetN)")
        
        print("------------------------------------------------")

        print("How many times were adjectives preceded by determiners?")
        let countDetAdj = queryBigramCount(previousTag: .determiner, nextTag: .adjective)
        print("Frequency of determiner-adjective pattern: \(countDetAdj)")
        
        print("------------------------------------------------")

        print("How many times were verbs followed by prepositions?")
        let countVP = queryBigramCount(previousTag: .verb, nextTag: .preposition)
        print("Frequency of verb-preposition pattern: \(countVP)")
        
        print("------------------------------------------------")

        
        print("How many times were verbs followed by nouns?")
        let countVN = queryBigramCount(previousTag: .verb, nextTag: .noun)
        print("Frequency of verb-noun pattern: \(countVN)")
        
        print("------------------------------------------------")


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //let bigramTagger = BigramTagger(delegate: self)
       // bigramTagger.tagBigrams(forText: MockData.article1.text)
        
        let simpleNGramTagger = SimpleNGramTagger(withText: MockData.article1.text)
        let bigrams = simpleNGramTagger.getBigrams()
        let trigrams = simpleNGramTagger.getTrigrams()
        
        bigrams.forEach{
            print("Bigram: \($0.n1) \($0.n2)")
        }
        
        trigrams.forEach{
            print("Trigram: \($0.n1) \($0.n2) \($0.n3)")
        }
        
        
        let countNV = simpleNGramTagger.numberOfBigrams(withTagPattern: [.noun,.verb])
        let countVN = simpleNGramTagger.numberOfBigrams(withTagPattern: [.verb,.noun])
        let countDetN = simpleNGramTagger.numberOfBigrams(withTagPattern: [.determiner,.noun])
        let countPN = simpleNGramTagger.numberOfBigrams(withTagPattern: [.preposition,.noun])
        
        print("Number of bigrams of type Noun-Verb: \(countNV)")
        print("Number of bigrams of type Verb-Noun: \(countVN)")
        print("Number of bigrams of type Determiner-Noun: \(countDetN)")
        print("Number of bigrams of type Preposition-Noun: \(countPN)")
        
        
        let countNVN = simpleNGramTagger.numberOfTrigrams(withTagPattern: [.noun,.verb,.noun])
        let countDetAdjN = simpleNGramTagger.numberOfTrigrams(withTagPattern: [.determiner,.adjective,.noun])
        let countAdjAdjN = simpleNGramTagger.numberOfTrigrams(withTagPattern: [.adjective,.adjective,.noun])
        let countPDetN = simpleNGramTagger.numberOfTrigrams(withTagPattern: [.preposition,.determiner,.noun])
        
        print("Number of trigrams of type Noun-Verb-Noun: \(countNVN)")
        print("Number of trigrams of type Determiner-Adjective-Noun: \(countDetAdjN)")
        print("Number of trigrams of type Adjective-Adjective-Noun: \(countAdjAdjN)")
        print("Number of trigrams of type Preposition-Determiner-Noun: \(countPDetN)")


        



    
    }
    
    
    func convertBigramsToTrigrams() -> [[TaggedWord]]{
        var trigrams = [[TaggedWord]]()
        
        for idx in 0..<self.bigrams.count where idx+1 < self.bigrams.count{
           
            let trigram = self.bigrams[idx] + [self.bigrams[idx+1].last!]
            trigrams.append(trigram)
        }
        
        return trigrams
    }
    
    func queryWordContext(middleTag: NLTag, previousTag: NLTag, nextTag: NLTag) ->Int{
        
        let trigrams = convertBigramsToTrigrams()
        
        let filteredTrigrams =  trigrams.filter{$0.first!.tag == previousTag && $0[1].tag == middleTag && $0.last!.tag == nextTag}
        
        print(filteredTrigrams)
        
        return filteredTrigrams.count

    }
    
    func queryBigramCount(previousTag: NLTag,nextTag: NLTag) -> Int{
        
        return self.bigrams.filter{$0.first!.tag == previousTag && $0.last!.tag == nextTag}.count
    }


}

