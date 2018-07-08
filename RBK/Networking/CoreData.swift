//
//  CoreData.swift
//  ParseJSON
//
//  Created by Антон Зайцев on 21.06.2018.
//  Copyright © 2018 Антон Зайцев. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //MARK: - Create entity from JSON
    func createEntity(json: Articles) -> NSManagedObject? {
        
        if let news = NSEntityDescription.insertNewObject(forEntityName: "News", into: context!) as? News {
            news.titleCD = json.title
            news.descriptionCD = json.description
            news.publishedCD = json.publishedAt
            news.urlCD = json.url
            news.imageCD = json.urlToImage
            return news
        }
        return nil
    }
    
    //MARK: - Save in CoreData
    func saveInCoreData(array: [Articles]) {
        _ = array.map{self.createEntity(json: $0)}
        do {
            try context?.save()
        } catch let error {
            print("Не получается сохранить. Ошибка - \(error)")
        }
    }
    
    //MARK: - Delete
    func clearData() {
        do {
            let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
            do {
                try context?.execute(deleteRequest)
                
            } catch let error {
                print("Не получается удалить. Ошибка - \(error)")
            }
        }
    }
}
