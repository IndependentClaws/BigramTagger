//
//  WordPosition.swift
//  NGramTagger
//
//  Created by Alex Makedonski on 9/16/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation

struct WordPosition: Comparable, CustomStringConvertible,Hashable{
    
    
    static func ==(lhs: WordPosition, rhs: WordPosition) -> Bool{
        return (lhs.paragraphPos == rhs.paragraphPos) && (lhs.sentencePos == rhs.sentencePos) && (lhs.wordPos == rhs.wordPos)
    }
    
    static func < (lhs: WordPosition, rhs: WordPosition) -> Bool {
        
        return (lhs.paragraphPos == rhs.paragraphPos) ? (lhs.sentencePos == rhs.sentencePos ? (lhs.wordPos < rhs.wordPos) : lhs.sentencePos < rhs.sentencePos) : (lhs.paragraphPos < rhs.paragraphPos)
    }
    
    let normalizedWordPos: Double
    let normalizedSentencePos: Double
    let normalizedParagraphPos: Double
    
    let paragraphPos: Int
    let sentencePos: Int
    let wordPos: Int
    
    var description: String{
        return "\tWordPositionInSentence: \(wordPos)\n\tSentencePosition:\(sentencePos)\n \tParagraphPosition: \(paragraphPos)\n\n\tNormalizedWordPosition:\(normalizedWordPos)\n\tNormalizedSentencePosition:\(normalizedSentencePos)\n\tNormalizedParagraphPosition:\(normalizedParagraphPos)"
    }
}
