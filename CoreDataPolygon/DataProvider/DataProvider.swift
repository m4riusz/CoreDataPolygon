import Foundation
import CoreData

class DataProvider: NSObject {
    
    private override init() {
        super.init()
    }
    
    public static let shared: DataProvider = DataProvider()
    typealias CoreDataSuccessCallback<T: Any> = (T) -> Void
    typealias CoreDataErrorCallback = (Error) -> Void
    
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
    
    func saveContext() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try context.save()
        }
    }
    
}


extension DataProvider {
    
    func homesAddNew(withStreet street: String?, withCity city: String?, withPostal postal: String?, withSuccessCallback onSuccess: CoreDataSuccessCallback<Home>?, withErrorCallback onError: CoreDataErrorCallback?) -> Void {
        
        let home: Home = Home(context: persistentContainer.viewContext)
        home.street = street
        home.city = city
        home.postal = postal
        home.persons = nil
        do {
            try saveContext()
            onSuccess?(home)
        } catch let error {
            onError?(error)
        }
        
    }
    
    func homesGetWithPredicate(_ predicate: NSPredicate? = nil,
                               withSortDescriptions sortDescriptions: [NSSortDescriptor]? = nil,
                               withSuccessCallback onSuccess: CoreDataSuccessCallback<[Home]>?,
                               withErrorCallback onError: CoreDataErrorCallback?) -> Void {
        do {
            let fetchRequest: NSFetchRequest = Home.fetchRequest()
            fetchRequest.predicate = predicate
            fetchRequest.sortDescriptors = sortDescriptions
            let homes: [Home] = try persistentContainer.viewContext.fetch(fetchRequest) as [Home]
            onSuccess?(homes)
        } catch let error {
            onError?(error)
        }
    }

}

extension DataProvider {
    
    func personsAddNew(withFirstName firstName: String, withLastName lastName: String, withCreateDate createDate: Date, withSuccessCallback onSuccess: CoreDataSuccessCallback<Person>?, withErrorCallback onError: CoreDataErrorCallback?) -> Void {
        
        let person: Person = Person(context: persistentContainer.viewContext)
        person.firstName = firstName
        person.lastName = lastName
        person.createDate = createDate as NSDate
        do {
            try saveContext()
            onSuccess?(person)
        } catch let error {
            onError?(error)
        }
        
    }
    
    func personsGetWithPredicate(_ predicate: NSPredicate? = nil,
                               withSortDescriptions sortDescriptions: [NSSortDescriptor]? = nil,
                               withSuccessCallback onSuccess: CoreDataSuccessCallback<[Person]>?,
                               withErrorCallback onError: CoreDataErrorCallback?) -> Void {
        do {
            let fetchRequest: NSFetchRequest = Person.fetchRequest()
            fetchRequest.predicate = predicate
            fetchRequest.sortDescriptors = sortDescriptions
            let persons: [Person] = try persistentContainer.viewContext.fetch(fetchRequest) as [Person]
            onSuccess?(persons)
        } catch let error {
            onError?(error)
        }
    }
    
    func personsUpdatePerson(_ person: Person,
                             withSuccessCallback onSuccess: CoreDataSuccessCallback<[Person]>?,
                             withErrorCallback onError: CoreDataErrorCallback?) -> Void {
        
    }
    
}

