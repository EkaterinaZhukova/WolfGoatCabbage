//
//  ViewModel.swift
//  WolfGoatCabbage
//
//  Created by Екатерина on 11/24/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import Foundation

class ViewModel: NSObject{
     @objc var service:EntityService
    
    @objc init(service:EntityService) {
        self.service = service
        super.init()
    }
    @objc func modelChanged(at index:Int,with state:EntityState){
        service.updateModel(index: index, with: state)
    }
    @objc func play(on cost:EntityState) -> Bool{
        return service.play(on: cost)
    }
    @objc func isWin() -> Bool{
        return service.isWin()
    }

    
    @objc func fetchData(for state:EntityState) -> [String]{
        let entities = service.getEntities().filter { (item) -> Bool in
            return item.state == state
        }
        return (entities.map{entityStrings[$0.type.rawValue]})
    }

    @objc func fetchId(for state:EntityState) -> [Int]{
        let entities = service.getEntities().filter { (item) -> Bool in
            return item.state == state
        }
        return entities.map{$0.id}
    }

}
