import Foundation
import CoreData

class DataProvider: NSObject {
    
    private override init() {
        super.init()
    }
    
    public static let shared: DataProvider = DataProvider()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataPolygon")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
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
    
}

extension DataProvider {
    
    func addNewHome(withStreet street: String?, withCity city: String?, withPostal postal: String?) -> Home {
        
        let home: Home = Home(context: persistentContainer.viewContext)
        home.street = street
        home.city = city
        home.postal = postal
        home.persons = nil
        saveContext()
        return home
    }
    
    func getHomes() -> [Home] {
        do {
            let homes: [Home] = try persistentContainer.viewContext.fetch(Home.fetchRequest()) as [Home]
            return homes
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
}
