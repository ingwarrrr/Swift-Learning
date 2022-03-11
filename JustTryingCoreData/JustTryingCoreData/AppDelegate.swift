//
//  AppDelegate.swift
//  JustTryingCoreData
//
//  Created by Igor on 08.03.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        // Оаисание сущности клиента
//        let entityDescription = NSEntityDescription.entity(forEntityName: "Client", in: CoreDataManager.instance.persistentContainer.viewContext)
//        
//        // создание объекта
//        // let managedObject = NSManagedObject(entity: entityDescription!, insertInto: persistentContainer.viewContext)
//        let managedObject = Client(entity: entityDescription!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
//        
//        // установка значения атрибута
//        // managedObject.setValue("Владимир", forKey: "name")
//        managedObject.name = "Степан"
//        
//        // извлечение значения атрибута
//        // let name = managedObject.value(forKey: "name")
//        let name = managedObject.name
//        print("name = \(String(describing: name))")
//        
//        // запись объекта
//        CoreDataManager.instance.saveContext()
//        // saveContext()
//        
//        // извлечение записей из хранилища
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Client")
//        do {
//            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
//            // for result in results as! [NSManagedObject] {
//            // print("name - \(String(describing: result.value(forKey: "name")!))")
//            for result in results as! [Client] {
//                print("name - \(result.name!)")
//                
//                // удаление объекта
//                CoreDataManager.instance.persistentContainer.viewContext.delete(result)
//            }
//        } catch {
//            print(error)
//        }
//        
//        // CoreDataManager.instance.saveContext()
//        // saveContext()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

