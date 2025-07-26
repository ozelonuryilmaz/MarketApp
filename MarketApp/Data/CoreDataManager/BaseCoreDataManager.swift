//
//  File.swift
//  MarketData
//
//  Created by Onur Yılmaz on 25.07.2025.
//

import CoreData

class BaseCoreDataManager<T: NSManagedObject> {
    
    internal let managedContext: NSManagedObjectContext

    internal var entityName: String {
        return String(describing: T.self)
    }

    init(managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }

    @discardableResult
    func deleteAllObjectsWithBatchRequest() -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
            return true
        } catch {
            print("Batch delete error: \(error.localizedDescription)")
            return false
        }
    }

    @discardableResult
    func saveContext() -> Bool {
        guard managedContext.hasChanges else { return true }

        do {
            try managedContext.save()
            return true
        } catch {
            print("Save context error: \(error.localizedDescription)")
            return false
        }
    }
}
