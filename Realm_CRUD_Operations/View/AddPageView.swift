//
//  AddPageView.swift
//  Realm_CRUD_Operations
//
//  Created by Maxim Macari on 5/1/21.
//

import SwiftUI

struct AddPageView: View {
    
    @EnvironmentObject var modelData: DBViewModel
    @Environment(\.presentationMode) var presentation
    
    
    var body: some View {
        
        NavigationView{
            List{
                Section(header: Text("Title")) {
                    TextField("", text: $modelData.title)
                }
                
                Section(header: Text("Detail")) {
                    TextField("", text: $modelData.detail)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(modelData.updateObject == nil ? "Add Data" : "Update")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        modelData.addData(presentation: presentation)
                    }, label: {
                        Text("Done")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
            }
        }
        .onAppear(){
            modelData.setUpInitialData()
        }
        .onDisappear(){
            modelData.deInitData()
        }
    }
}

struct AddPageView_Previews: PreviewProvider {
    static var previews: some View {
        AddPageView()
    }
}
