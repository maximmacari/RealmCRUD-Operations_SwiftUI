//
//  Homee.swift
//  Realm_CRUD_Operations
//
//  Created by Maxim Macari on 5/1/21.
//

import SwiftUI

struct Home: View {
    
    @StateObject var modelData = DBViewModel()
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack(spacing: 15){
                    ForEach(modelData.cards) { card in
                        VStack(alignment: .leading, spacing: 10, content: {
                            Text("\(card.title)")
                            Text("\(card.detail)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background(
                            Color.gray.opacity(0.15)
                        )
                        .cornerRadius(16)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .contextMenu(ContextMenu(menuItems: {
                            Button(action: {
                                modelData.deleteData(object: card)
                            }, label: {
                                Text("Delete Item")
                            })
                            
                            Button(action: {
                                modelData.updateObject = card
                                modelData.openNewPage.toggle()
                            }, label: {
                                Text("Update Item")
                            })
                            
                        }))
                    }
                }
                
            }
            .navigationTitle("Realm DB")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    
                    Button(action: {
                        modelData.openNewPage.toggle()
                    }, label: {
                         Image(systemName: "plus")
                            .font(.title2)
                    })
                    
                    
                }
            }
            .sheet(isPresented: $modelData.openNewPage, content: {
                AddPageView()
                    .environmentObject(modelData)
            })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
