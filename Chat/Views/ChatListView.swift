//
//  ContentView.swift
//  Chat
//
//  Created by Kadek Edwin on 22/08/23.
//

import SwiftUI

struct ChatListView: View {
    let dataController = DataController.shared

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var contacts: FetchedResults<Contact>
    
    @State var searchText = ""
    @State private var showAddView = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(contacts) { contact in
                    NavigationLink(destination: ChatView()) {
                        Image(contact.photo ?? "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                            .clipped()
                            .cornerRadius(25)
                        VStack(alignment: .leading){
                            Text(contact.name ?? "name")
                                .font(.headline)
//                            Text(contact.lastMessage)
//                                .font(.body)
//                                .foregroundColor(.secondary)
                        }
                    }
                }.onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        dataController.deleteContact(contact: contacts[index], context: viewContext)
                    }
                })
            }
            .navigationTitle("Chats")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddView.toggle()
                    } label: {
                        Label("Add food", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddView) {
                AddContactView()
            }
            
        }
        .searchable(text: $searchText)
            
    }
}

#Preview {
    ChatListView().environment(\.managedObjectContext, DataController.preview.container.viewContext)
}
