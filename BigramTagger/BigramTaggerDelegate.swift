//
//  BigramTaggerDelegate.swift
//  NGramTagger
//
//  Created by Alex Makedonski on 9/16/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation

protocol BigramTaggerDelegate{
    
    
    func didStartParsingBigrams()
    
    func didFindBigram(withCurrentNGram currentNGram: TaggedWord?, andWithPreviousNGram previousNGram: TaggedWord?)
    
    func didFinishParsingBigrams(withBigrams bigrams: [[TaggedWord]])
}
