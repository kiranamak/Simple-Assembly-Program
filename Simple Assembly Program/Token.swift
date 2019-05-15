//
//  Token.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 5/7/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

struct Token: CustomStringConvertible {
    let type: TokenType
    let int: Int?
    let string: String?
    let tuple: Tuple?
    
    init(_ type: TokenType, int: Int? = nil, string: String? = nil, tuple: Tuple? = nil) {
        self.type = type
        self.int = int
        self.string = string
        self.tuple = tuple
    }
    var description: String {
        return type.rawValue
    }
}
