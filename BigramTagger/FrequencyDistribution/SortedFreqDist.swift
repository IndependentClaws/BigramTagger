//
//  FrequencyDistribution.swift
//  Just the Facts Please
//
//  Created by Alex Makedonski on 9/8/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation

//How to inherite from generic class?
class SortableFrequencyDistribution<T>:SimpleFrequencyDistribution<T> where T:Tokenizable{
   

    
    public func getSortedWordFrequencyArray() -> [WordFrequency<T>]{
        
        return getWordFrequencyArray().sorted(by: { $0.frequency > $1.frequency})

    }
    
     
 
    func topWordFrequency() -> WordFrequency<T>?{
 
 
        guard let topFrequency = topWordFrequencies(n: 1).first else {
            return nil
        }
 
        return topFrequency
    }
 
    func bottomWordFrequency() -> WordFrequency<T>?{
 
        guard let bottomFrequency = bottomWordFrequencies(n: 1).first else {
                return nil
            }
 
            return bottomFrequency
    }
 
    func bottomWordFrequencies(n: Int) -> [WordFrequency<T>]{
 
        let sortedKVArray = getSortedWordFrequencyArray()
 
            let start = sortedKVArray.count-n
            let end = sortedKVArray.count
 
            return Array<WordFrequency>(sortedKVArray[start..<end])
        }
 
    func topWordFrequencies(n: Int) -> [WordFrequency<T>]{
 
        let sortedKVArray = getSortedWordFrequencyArray()
 
            return Array<WordFrequency>(sortedKVArray[0..<n])
    }

}
 

