//
//  AddContactView.swift
//  Chat
//
//  Created by Kadek Edwin on 23/08/23.
//

import SwiftUI

struct AddContactView: View {
    let dataController = DataController.shared
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var photo = ""
    
    var body: some View {
        Form {
            Section() {
                TextField("Name", text: $name)
                TextField("Photo", text: $photo)
                
                HStack{
                    Spacer()
                    Button("Add") {
                        dataController.addContact(
                            name: name,
                            photo: photo,
                            context: viewContext
                        )
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
    
}

#Preview {
    AddContactView()
}
