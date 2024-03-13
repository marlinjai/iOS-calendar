//
//  AddressBook.swift
//  iOS5-Pohl
//
//  Created by Marlin Pohl on 14.11.23.
//

import Foundation

class AddressBook: Codable {
    var addressBook = [AddressCard]()
    
    init(){
    }
    
    func add(card: AddressCard){
        addressBook.append(card)
    }
    
    func remove(card: AddressCard){
        for  address in addressBook {
            address.remove(oldFriend: card)
        }
        let index: Int? = addressBook.firstIndex(of: card)
        if let realIndex = index {
            addressBook.remove(at: realIndex)
        }
    }
    
    func sort(){
        addressBook.sort(by: {address1, address2 in address1.nachname > address2.nachname})
    }
    
    func searchFirstLastname(input: String) -> AddressCard? {
        let lowercasedInput = input.lowercased()

        for address in addressBook {
            if address.nachname.lowercased().contains(lowercasedInput) {
                return address
            }
        }
        return nil
    }
    
    func searchId(searchId: UUID) -> AddressCard?{
        for address in addressBook {
            if(address.id == searchId){return address}
        }
        return nil
    }
    
    func friendsOf(card: AddressCard) -> [AddressCard] {
        
        var allFriends: [AddressCard] = []
        for friend in card.freunde {
            if let friendCard = searchId(searchId: friend) {
                allFriends.append(friendCard)
            }
        }
        return allFriends
    }
    
    
    
    func save(toFile path: String) {
        let url = URL(fileURLWithPath: path)
        
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self){ // Encode the current instance
            try? data.write(to: url)
        }
    }
       
       class func addressBook(fromFile path: String) -> AddressBook? {
           let url = URL(fileURLWithPath: path)
           
           if let data = try? Data(contentsOf: url) {
               let decoder = JSONDecoder()
               if let addressBook = try? decoder.decode(AddressBook.self, from: data){
                   return addressBook // Return the decoded AddressBook
               }
           }
           return nil
       }
    
}
