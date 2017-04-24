//
//  FoodTableItemClass.swift
//  FoodTracker
//
//  Created by Joshua on 4/3/17.
//  Copyright © 2017 Joshua. All rights reserved.
//

import Foundation

class FoodTableItemClass{
    private var name: String
    private var brand: String
    private var date : Date
    
    init(name:String, brand:String, date:Date ) {
        self.name = name
        self.brand = brand
        self.date = date
    }
    /*
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as! String
        self.brand = decoder.decodeObject(forKey: "brand") as! String
        self.date = decoder.decodeObject(forKey: "currentDate") as! Date
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.brand, forKey: "brand")
        coder.encode(self.date, forKey: "currentDate")
    }*/
    
    
}
