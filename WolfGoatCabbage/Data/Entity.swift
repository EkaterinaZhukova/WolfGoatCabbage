//
//  Entity.swift
//  WolfGoatCabbage
//
//  Created by Екатерина on 11/24/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import Foundation
enum EntityType:String{
    case Wolf = "Wolf"
    case Goat = "Goat"
    case Cabbage = "Cabbage"

}

@objc enum EntityState:Int{
    case isInBoat
    case isOnTheLeft
    case isOnTheRight
}


class Entity: NSObject {
    private static var id_ = 0
    let type:EntityType
    var state:EntityState
    let id:Int
    
    init(type: EntityType) {
        Entity.id_ += 1
        self.type = type
        self.id = Entity.id_
        self.state = EntityState.isOnTheLeft
    }
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Entity{
            return self.type == object.type
        }
        else{
            return false
        }
    }
}
