//
//  CoreDataManagerMock.swift
//  HatchworksCodeChallengeTests
//
//  Created by Juan David Lopera Lopez on 25/11/25.
//

import CoreData
@testable import HatchworksCodeChallenge

final class MockCoreDataManager: CoreDataManagerProtocol {
    var mockPurchases: [Purchases] = []
    
    lazy var context: NSManagedObjectContext = {
        let model = NSManagedObjectModel()
        
        let entity = NSEntityDescription()
        entity.name = "Purchases"
        entity.managedObjectClassName = NSStringFromClass(Purchases.self)
        
        let idAttr = NSAttributeDescription()
        idAttr.name = "id"
        idAttr.attributeType = .integer64AttributeType
        idAttr.isOptional = false
        
        let titleAttr = NSAttributeDescription()
        titleAttr.name = "title"
        titleAttr.attributeType = .stringAttributeType
        titleAttr.isOptional = false
        
        let dateAttr = NSAttributeDescription()
        dateAttr.name = "date"
        dateAttr.attributeType = .dateAttributeType
        dateAttr.isOptional = true
        
        entity.properties = [idAttr, titleAttr, dateAttr]
        model.entities = [entity]
        
        let container = NSPersistentContainer(name: "TestContainer", managedObjectModel: model)
        let desc = NSPersistentStoreDescription()
        desc.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [desc]
        
        container.loadPersistentStores { storeDesc, error in
            if let error = error {
                fatalError("Failed to load in-memory store: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return container.viewContext
    }()
    
    
    func fetchPurchases(context: NSManagedObjectContext) -> [Purchases] {
        return mockPurchases
    }
    
    func saveContext(selectedContext: NSManagedObjectContext) throws {
        if selectedContext.hasChanges {
            try selectedContext.performAndWait {
                do {
                    debugPrint("✅ Mock saveContext called")
                } catch {
                    selectedContext.rollback()
                    throw error
                }
            }
        }
    }
}
