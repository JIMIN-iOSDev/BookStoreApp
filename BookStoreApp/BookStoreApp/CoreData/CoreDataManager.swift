//
//  CoreDataManager.swift
//  BookStoreApp
//
//  Created by Jimin on 1/5/25.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    // MARK: - Core Data stack
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BookStoreCoreData")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("CoreData store failed to load: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveBook(_ book: Book) {
        let savedBook = SavedBook(context: context)
        savedBook.title = book.title
        savedBook.authors = book.authors.joined(separator: ", ")
        savedBook.contents = book.contents
        savedBook.thumbnail = book.thumbnail
        savedBook.saleprice = Int64(book.salePrice)
        
        do {
            try context.save()
        } catch {
            print("Failed to save book: \(error)")
        }
    }
    
    func fetchBooks() -> [SavedBook] {
        let request: NSFetchRequest<SavedBook> = SavedBook.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch books: \(error)")
            return []
        }
    }
    
    func deleteBook(_ book: SavedBook) {
        context.delete(book)
        try? context.save()
    }
    
    func deleteAllBooks() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = SavedBook.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: context)
        } catch {
            print("Error executing delete request: \(error)")
        }
    }
}
