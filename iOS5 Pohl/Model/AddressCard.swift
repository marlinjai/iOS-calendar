//
//  AddressCArd.swift
//  iOS5-Pohl
//
//  Created by Marlin Pohl on 14.11.23.
//

import Foundation

class AddressCard: Identifiable, Codable, Equatable, Hashable {
    static func == (lhs: AddressCard, rhs: AddressCard) -> Bool {
        lhs.id == rhs.id
    }
    
    
    var id = UUID()
    
    var vorname: String
    var nachname: String
    var straße: String
    var plz: Int
    var ort: String
    var hobbies: [Hobby]
    var freunde: [AddressCard.ID]
   

    init(id: UUID = UUID(), vorname: String, nachname: String, straße: String, plz: Int,ort: String, hobbies: [Hobby], freunde: [AddressCard.ID]) {
        self.id = id
        self.vorname = vorname
        self.nachname = nachname
        self.straße = straße
        self.plz = plz
        self.ort = ort
        
        self.hobbies = hobbies
        self.freunde = freunde
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func addHobby(newHobby: Hobby){
        hobbies.append(newHobby)
    }

    func add(newFriend: AddressCard){
        freunde.append(newFriend.id)
    }
    
    func remove(oldFriend: AddressCard){
        let index: Int? = freunde.firstIndex(of: oldFriend.id)
        
        if let existingIndex = index{
            freunde.remove(at: existingIndex)
        }
    }
    
    func printCard(){
        let first =
        """
        +-------------------------
        | \(self.vorname) \(self.nachname)
        | \(self.straße)
        | \(self.plz) \(self.ort)
        """
        var second = """

| Hobbies:

"""
        
        for hobby in hobbies {
            second +=
        """
    |   \(hobby.name)

"""
        }
        
        print(first+second)
        }
    
}



