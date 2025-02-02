//
//  CoreDataStack.swift
//  DataCustom
//
//  Created by MacStudent on 2020-01-15.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import Foundation
import  CoreData

class CoreDataStack {

  private let modelName: String

  init(modelName: String) {
    self.modelName = modelName
  }

  lazy var managedContext: NSManagedObjectContext = { //
    return self.storeContainer.viewContext
  }()

  private lazy var storeContainer: NSPersistentContainer = {//value is not calculated until it is used first time
    let container = NSPersistentContainer(name: self.modelName)
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        print("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()

  func saveContext () {
    guard managedContext.hasChanges else { return }
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Unresolved error \(error), \(error.userInfo)")
    }
  }
}
