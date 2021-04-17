//
//  String+Extensions.swift
//  Loggle
//
//  Created by Chris Davis on 17/04/2021.
//

import Foundation
//
//extension String {
//    static let escapeSequences = [
//        (original: "\0", escaped: "\\0"),
//        (original: "\\", escaped: "\\\\"),
//        (original: "\t", escaped: "\\t"),
//        (original: "\n", escaped: "\\n"),
//        (original: "\r", escaped: "\\r"),
//        (original: "\"", escaped: "\\\""),
//        (original: "\'", escaped: "\\'"),
//    ]
//
//    mutating func literalize() {
//        self = self.literalized()
//    }
//
//    func literalized() -> String {
//        return String.escapeSequences.reduce(self) { string, seq in
//            string.replacingOccurrences(of: seq.original, with: seq.escaped)
//        }
//    }
//}
