//
//  DataController.swift
//  Chat
//
//  Created by Kadek Edwin on 23/08/23.
//

import Foundation
import CoreData

struct DataController {
    static let shared = DataController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ContactModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    static var preview: DataController = {
        let result = DataController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<5 {
            let contact = Contact(context: viewContext)
            contact.id = UUID()
            contact.name = "Test"
            contact.photo = "User1"
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully")
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    func addContact(name: String, photo: String, context: NSManagedObjectContext) {
        let contact = Contact(context: context)
        contact.id = UUID()
        contact.name = name
        contact.photo = photo

        save(context: context)
    }
    
    func editContact(contact: Contact, name: String, photo: String, context: NSManagedObjectContext) {
        contact.name = name
        contact.photo = photo

        save(context: context)
    }
    
    func deleteContact(contact: Contact, context: NSManagedObjectContext) {
        context.delete(contact)
        
        save(context: context)
    }
    
}
