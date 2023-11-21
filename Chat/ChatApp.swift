//
//  ChatApp.swift
//  Chat
//
//  Created by Kadek Edwin on 22/08/23.
//

import SwiftUI

@main
struct ChatApp: App {
    let dataController = DataController.shared
    
    var body: some Scene {
        WindowGroup {
            ChatListView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
