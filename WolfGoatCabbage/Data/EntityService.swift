//
//  EntityService.swift
//  WolfGoatCabbage
//
//  Created by Екатерина on 11/24/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import Foundation


class EntityService:NSObject{
    var entityArr:[Entity]

    private let wolf = Entity(type: .Wolf)
    private let goat = Entity(type: .Goat)
    private let cabbage = Entity(type: .Cabbage)
    
    override init() {
        entityArr = [Entity]()
        entityArr.append(Entity(type: .Goat))
        entityArr.append(Entity(type: .Wolf))
        entityArr.append(Entity(type: .Cabbage))
    }
    func play(on cost:EntityState) -> Bool{
        let state:EntityState
        cost == .isOnTheLeft ? (state = EntityState.isOnTheRight) : (state = EntityState.isOnTheLeft)
        let arr = entityArr.filter { (entity) -> Bool in
            return entity.state == state
        }
        if(arr.contains(goat)){
            if(arr.contains(wolf)){
                return false
            }
            if(arr.contains(cabbage)){
                return false
            }
        }
        return true
    }
    func getEntities() -> [Entity]{
        return self.entityArr
    }
    func isWin() -> Bool{
        for item in entityArr{
            if(item.state != .isOnTheRight){
                return false
            }
        }
        return true
    }
    func updateModel(index:Int,with state:EntityState){
        let item = entityArr.filter { (entity) -> Bool in
            return entity.id == index
        }
        item.first?.state = state
    }
}
