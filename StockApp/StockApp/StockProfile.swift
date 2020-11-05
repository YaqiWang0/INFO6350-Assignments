//
//  StockProfile.swift
//  StockApp
//
//  Created by Yaqi Wang on 11/4/20.
//

import Foundation
import RealmSwift

class StockProfile: Object {
    @objc dynamic var symbol: String! = ""
    @objc dynamic var price : Double = 0.0
    //@objc dynamic var description : String! = ""
    @objc dynamic var ceo : String! = ""
    
    init(_ symbol : String) {
        super.init()
        self.symbol = symbol;
    }
    
    required init() {
    }
    
    override static func primaryKey() -> String? {
        return "symbol";
    }
}
