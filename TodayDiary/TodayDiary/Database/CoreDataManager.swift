//
//  CoreDataManager.swift
//  TodayDiary
//
//  Created by 서정원 on 5/12/25.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(
            completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - Create
    func saveDiary(currentDay: Date, emoji: String?, howToday: String?, good: String?, improve: String?) {
        let context = persistentContainer.viewContext
        let entity = Entity(context: context)
        
        entity.currentDay = currentDay
        entity.emoji = emoji
        entity.howToday = howToday
        entity.good = good
        entity.improve = improve
        
        saveContext()
    }
    
    func fetchDiaries() -> [Entity] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "currentDay", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let diaries = try context.fetch(fetchRequest)
            return diaries
        } catch {
            print("Error fetching diaries: \(error)")
            return []
        }
    }
    
    func hasDiaryDate(date: Date) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        fetchRequest.predicate = NSPredicate(format: "currentDay >= %@ AND currentDay < %@", startOfDay as NSDate, endOfDay as NSDate)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking diary existence: \(error)")
            return false
        }
    }
    
    func fetchDiary(for date: Date) -> Entity? {
        let context = persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        fetchRequest.predicate = NSPredicate(format: "currentDay >= %@ AND currentDay < %@", startOfDay as NSDate, endOfDay as NSDate)

        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Error fetching diary: \(error)")
            return nil
        }
    }
}
