//
//  Hobby.swift
//  iOS5-Pohl
//
//  Created by Marlin Pohl on 14.11.23.
//

import Foundation

func == (left: Hobby, right: Hobby) -> Bool {return left.id == right.id}

class Hobby: Identifiable, Codable, Equatable {
    var id = UUID();
    var name: String;
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
        
    }
}
