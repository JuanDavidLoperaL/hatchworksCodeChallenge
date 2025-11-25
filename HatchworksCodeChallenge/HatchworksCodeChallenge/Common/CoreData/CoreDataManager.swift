//
//  CoreDataManager.swift
//  HatchworksCodeChallenge
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import CoreData

protocol CoreDataManagerProtocol {
    var context: NSManagedObjectContext { get }
    func fetchPurchases(context: NSManagedObjectContext) -> [Purchases]
    func saveContext(selectedContext: NSManagedObjectContext) throws
}

final class CoreDataManager: CoreDataManagerProtocol {
    static let shared = CoreDataManager()
    
    private let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "HistoryPurchases")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                debugPrint("❌ Error loading data from coreData: \(error.localizedDescription)")
                
                if let url = description.url {
                    do {
                        try FileManager.default.removeItem(at: url)
                        try self.container.persistentStoreCoordinator.addPersistentStore(
                            ofType: description.type,
                            configurationName: nil,
                            at: url,
                            options: description.options
                        )
                        debugPrint("✅ Store re-created successfully")
                    } catch {
                        fatalError("Unresolved error \(error)")
                    }
                }
            } else {
                debugPrint("✅ CoreData working properly")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    // MARK: - Computed Properties
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    // MARK: - Internal Function
    func saveContext(selectedContext: NSManagedObjectContext) throws {
        if selectedContext.hasChanges {
            try selectedContext.performAndWait {
                do {
                    try selectedContext.save()
                    debugPrint("✅ Saved successfully")
                } catch {
                    selectedContext.rollback()
                    debugPrint("❌ Failed to save context: \(error.localizedDescription)")
                    throw error
                }
            }
        }
    }
    
    func fetchPurchases(context: NSManagedObjectContext) -> [Purchases] {
        let request: NSFetchRequest<Purchases> = Purchases.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let purchases = try context.fetch(request)
            return purchases
        } catch {
            debugPrint("❌ Error fetching purchases: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - Background Context
    func newBackgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
}
