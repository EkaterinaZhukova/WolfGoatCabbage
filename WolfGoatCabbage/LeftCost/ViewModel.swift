//
//  ViewModel.swift
//  WolfGoatCabbage
//
//  Created by Екатерина on 11/24/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import Foundation

class ViewModel: NSObject{
    private var service:EntityService
    
    init(service:EntityService) {
        self.service = service
        super.init()
    }
    func modelChanged(at index:Int,with state:EntityState){
        service.updateModel(index: index, with: state)
    }
    func play(on cost:EntityState) -> Bool{
        return service.play(on: cost)
    }
    func isWin() -> Bool{
        return service.isWin()
    }

    
    func fetchData(for state:EntityState) -> ([String],[Int]){
        let entities = service.getEntities().filter { (item) -> Bool in
            return item.state == state
        }
        return (entities.map{$0.type.rawValue},entities.map{$0.id})
    }

}
