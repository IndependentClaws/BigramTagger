//
//  String+Extensions.swift
//  BigramTagger
//
//  Created by Alex Makedonski on 9/17/19.
//  Copyright © 2019 Alex Makedonski. All rights reserved.
//

import Foundation

extension String{

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
