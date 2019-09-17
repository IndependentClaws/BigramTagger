//
//  TaggedWord.swift
//  NGramTagger
//
//  Created by Alex Makedonski on 9/16/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation
import NaturalLanguage

struct TaggedWord: Tokenizable, CustomStringConvertible,Hashable{
    
    static func == (lhs: TaggedWord, rhs: TaggedWord) -> Bool {
        
        var conditions = [Bool]()
        
        if let lhsPosition = lhs.wordPosition, let rhsPosition = rhs.wordPosition{
            conditions.append(lhsPosition == rhsPosition)
        }
        
        conditions.append(lhs.word == rhs.word)
        conditions.append(lhs.tag == rhs.tag)
        
        return conditions.reduce(true){$0 && $1}
    }
    
    
    static let ProperNounSet: Set<NLTag> = [.placeName,.organizationName,.personalName]
    
    static let IndirectObjectPronouns: Set<String> = ["him","her","me","us","them","you","it"]
    
    static let DemonstrativePronouns: Set<String> = ["this","that","these","those"]
    
    static let PossessivePronouns: Set<String> = ["my","your","his","her","its","our","their"]
    
    static let Determiners: Set<String> = ["the","a","an"]
    
    static let NounPhraseHeadWords = TaggedWord.PossessivePronouns.union(TaggedWord.DemonstrativePronouns).union(TaggedWord.Determiners)
    
    var wordToken: String{
        return self.word
    }
    
    var word: String
    
    var tag: NLTag
    var wordPosition: Int?
    
    init(){
        self.word = String()
        self.tag = NLTag.other
    }
    
    init(word: String, tag: NLTag) {
        self.word = word
        self.tag = tag
    }
    
    var description: String{
        return "\(word)/\(tag.rawValue)"
    }
    
    //MARK: Helper Functions
    
    func isPreposition() -> Bool{
        return tag == .preposition
    }
    
    func isDeterminer() -> Bool{
        return tag == .determiner
        
    }
    
    func isAdverb() -> Bool{
        return tag == .adverb
    }
    
    func isAdjective() -> Bool{
        return tag == .adjective
    }
    
    
    func isConjunction() -> Bool{
        return tag == .conjunction
    }
    
    
    func isVerb() -> Bool{
        return tag == .verb
    }
    
    func isProperNoun() -> Bool{
        let properNounTagSet: Set<NLTag> = [.personalName,.organizationName,.placeName]
        return properNounTagSet.contains(self.tag)
    }
    
    
    func isNoun() -> Bool{
        return tag == .noun
    }
    
    
    func isGeneralNoun() -> Bool{
        return isNoun() || isProperNoun()
    }
    
    
    func isPronoun() -> Bool{
        return tag == .pronoun
    }
    
    func isOtherWord() -> Bool{
        return tag == .otherWord
    }
    
    func isOther() -> Bool{
        return tag == .other
    }
    
    func isIdiom() -> Bool{
        return tag == .idiom
    }
    
    func isNumber() -> Bool{
        return tag == .number
    }
    
    
    func isIndirectObjectPronoun() -> Bool{
        return TaggedWord.IndirectObjectPronouns.contains(self.tag.rawValue.lowercased())
    }
    
    func isDemonstrativePronoun() -> Bool{
        return TaggedWord.DemonstrativePronouns.contains(self.tag.rawValue.lowercased())
    }
    
    func isPossessivePronoun() -> Bool{
        return TaggedWord.PossessivePronouns.contains(self.tag.rawValue.lowercased())
    }


    
    
}
