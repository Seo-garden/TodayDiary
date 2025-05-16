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
    func saveDiary(currentDay: Date, emoji: String, howToday: String, good: String, improve: String) {
        let context = persistentContainer.viewContext
        let entity = Entity(context: context)
        
        entity.currentDay = currentDay
        entity.emoji = emoji
        entity.howToday = howToday
        entity.good = good
        entity.improve = improve
        
        saveContext()
    }
    
    func readDiary(emoji: String, howToday: String, good: String, improve: String) {
        let context = persistentContainer.viewContext
        let entity = Entity(context: context)
        
        
        entity.emoji = emoji
        entity.howToday = howToday
        entity.good = good
        entity.improve = improve
    }
        
}
