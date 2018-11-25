//
//  Entity.swift
//  WolfGoatCabbage
//
//  Created by Екатерина on 11/24/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import Foundation


let entityStrings = ["Wolf","Goat","Cabbage"]
@objc enum EntityType:Int{
    case Wolf = 0
    case Goat = 1
    case Cabbage = 2
}

@objc enum EntityState:Int{
    case isInBoat
    case isOnTheLeft
    case isOnTheRight
}


class Entity: NSObject {
    private static var id_ = 0
    @objc let type:EntityType
    @objc var state:EntityState
    @objc let id:Int
    
    @objc init(type: EntityType) {
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
