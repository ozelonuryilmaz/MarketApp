//
//  BaseCoreDataManager.swift
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

    // MARK: Init

    init(managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }

    // MARK: Save
    /// Saves context if there are any changes
    /// - Returns: true if save succeeded
    @discardableResult
    func saveContext() -> Bool {
        guard managedContext.hasChanges else { return true }

        var saveSucceeded = false
        managedContext.performAndWait {
            do {
                try managedContext.save()
                saveSucceeded = true
            } catch {
                print("Save context error: \(error.localizedDescription)")
            }
        }
        return saveSucceeded
    }

    // MARK: Batch Delete (Tümünü Sil)
    /// Deletes all objects of type `T` using batch request
    /// - Returns: true if deletion succeeded
    @discardableResult
    func deleteAllObjectsWithBatchRequest() -> Bool {
        var deleteSucceeded = false
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs

        managedContext.performAndWait {
            do {
                let result = try managedContext.execute(deleteRequest) as? NSBatchDeleteResult
                if let objectIDs = result?.result as? [NSManagedObjectID] {
                    let changes = [NSDeletedObjectsKey: objectIDs]
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [managedContext])
                }
                try managedContext.save()
                deleteSucceeded = true
            } catch {
                print("Batch delete error: \(error.localizedDescription)")
            }
        }

        return deleteSucceeded
    }

    // MARK: Generic Fetch Helper
    /// Generic fetch function with optional predicate and sort
    func fetchObjects(predicate: NSPredicate? = nil,
                      sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let request = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors

        var result: [T] = []
        managedContext.performAndWait {
            do {
                result = try managedContext.fetch(request)
            } catch {
                print("Fetch error: \(error.localizedDescription)")
            }
        }
        return result
    }
}
