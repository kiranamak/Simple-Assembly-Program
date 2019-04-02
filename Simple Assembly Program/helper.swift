//
//  helper.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

func unicodeValueToCharacter(_ n: Int) -> Character {
    return Character(UnicodeScalar(n)!)
}

func splitStringIntoParts(_ expression: String) -> [Int] {
    return expression.split{$0 == " " || $0 == "\n"  || $0 == "\t" }.map{ Int($0)! }
    
}
