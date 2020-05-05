//
//  ShikiCatalogFilter.swift
//  shikijappios
//
//  Created by Pavel on 05.05.2020.
//  Copyright © 2020 Pagala Co. All rights reserved.
//

import Foundation

struct ShikiCatalogParameters {
    var kind: String
    var rating: String
    var status: String
}

class CollectionParameter<T: Hashable>: ObservableObject {
    @Published private var include = Set<T>()
    @Published private var exclude = Set<T>()
    
    typealias sed = T
    
    func addInclude(item: T) {
        exclude.remove(item)
        include.insert(item)
        objectWillChange.send()
    }
    
    func addExclude(item: T) {
        exclude.insert(item)
        include.remove(item)
        objectWillChange.send()
    }
    
    func remove(item: T) {
        exclude.remove(item)
        include.remove(item)
        objectWillChange.send()
    }
    
    func contains(item: T) -> Bool {
        return include.contains(item) || exclude.contains(item)
    }
    
    func containsInclude(item: T) -> Bool {
        return include.contains(item)
    }
    
    func containsExclude(item: T) -> Bool {
        return exclude.contains(item)
    }
    
    func clear() {
        include = Set()
        exclude = Set()
    }
    
    func toString() -> String {
        var string = ""
        for idx in include.indices {
            if (idx != include.startIndex) {
                if include[idx] is ShikiEnum {
                    string += "," + (include[idx] as! ShikiEnum).getCode()
                }
            } else {
                if include[idx] is ShikiEnum {
                    string += (include[idx] as! ShikiEnum).getCode()
                }
            }
        }
        for idx in exclude.indices {
            if (idx != exclude.startIndex) {
                if exclude[idx] is ShikiEnum {
                    string += ",!" + (exclude[idx] as! ShikiEnum).getCode()
                }
            } else {
                if (!include.isEmpty) {
                    string += ","
                }
                if exclude[idx] is ShikiEnum {
                    string += "!" + (exclude[idx] as! ShikiEnum).getCode()
                }
            }
        }
        return string
    }
}
