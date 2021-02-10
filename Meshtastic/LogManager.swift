//
//  LogManager.swift
//  Meshtastic-iOS
//
//  Created by Evgeny Yagrushkin on 2020-05-03.
//  Copyright © 2020 Meshtastic. All rights reserved.
//

import Foundation

func Log(_ text: Any?, funcName: String = #function) {
    if let text = (text as AnyObject).description {
        print("\(funcName):\n\(text.description)")
    } else {
        print("\n\(funcName)")
    }
}

extension Data {
    var hexDescription: String {
        return reduce("") {$0 + String(format: "%02x", $1)}
    }
}

extension Data {
    
    func toString() -> String {
        return self.map { String(format: "%02hhx", $0) }.joined()
    }
    
}
