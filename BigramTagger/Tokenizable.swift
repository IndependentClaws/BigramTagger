//
//  Tokenizable.swift
//  NGramTagger
//
//  Created by Alex Makedonski on 9/16/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation


protocol Tokenizable:Hashable{
    
    var wordToken: String {get}
}

