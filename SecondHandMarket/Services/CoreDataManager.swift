//
//  CoreDataManager.swift
//  SecondHandMarket
//
//  Created by HongTuan on 05/06/2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "SecondHandMarket")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
//    func updateMovie() {
//
//        do {
//            try persistentContainer.viewContext.save()
//        } catch {
//            persistentContainer.viewContext.rollback()
//        }
//
//    }
//
//    func deleteMovie(movie: UserCoreData) {
//
//        persistentContainer.viewContext.delete(movie)
//
//        do {
//            try persistentContainer.viewContext.save()
//        } catch {
//            persistentContainer.viewContext.rollback()
//            print("Failed to save context \(error)")
//        }
//
//    }
    
    func getUser() -> [UserCoreData] {
        let fetchRequest: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
    
//    func saveMovie(title: String) {
//
//        let movie = Movie(context: persistentContainer.viewContext)
//        movie.title = title
//
//        do {
//            try persistentContainer.viewContext.save()
//        } catch {
//            print("Failed to save movie \(error)")
//        }
//
//    }
    
}
