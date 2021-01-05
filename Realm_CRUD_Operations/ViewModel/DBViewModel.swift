//
//  DBViewModel.swift
//  Realm_CRUD_Operations
//
//  Created by Maxim Macari on 5/1/21.
//

import SwiftUI
import RealmSwift

class DBViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var detail = ""
    
    @Published var openNewPage = false
    
    //fetch data
    @Published var cards: [Card] = []
    
    //Data updation
    @Published var updateObject: Card?
    
    init() {
        self.fetchData()
    }
    
    func fetchData() {
        guard let dbRef = try? Realm() else {
            return
        }
        
        let results = dbRef.objects(Card.self)
        
        //Displaying results
        
        self.cards = results.compactMap({ (card) -> Card? in
            return card
        })
    }
    
    
    //Adding new data
    
    func addData(presentation: Binding<PresentationMode>) {
        
        let card = Card()
        card.title = title
        card.detail = detail
        
        //getting reference
        
        guard let dbRef = try? Realm() else {
            return
        }
        
        //Writting data
        try? dbRef.write{
            
            //Cheking and writing data
            guard let availableObject = updateObject else {
                dbRef.add(card)
                return
            }
            availableObject.title = title
            availableObject.detail = detail
        }
        // Update UI
        fetchData()
        
        // Closing View
        presentation.wrappedValue.dismiss()
        
    }
    
    //Delete Data
    func deleteData(object: Card) {
        guard let dbRef = try? Realm() else {
            return
        }
        
        try? dbRef.write{
            dbRef.delete(object)
            
            fetchData() // update
        }
        
        
    }
    
    //Setting and cleaering data
    func setUpInitialData(){
    
        guard let updateData = updateObject else {
             return
        }
        
        //Cheking if its update object and assiging values
        title = updateData.title
        detail = updateData.detail
    }
    
    func deInitData(){
        title = ""
        detail = ""
    }
    
    
}

