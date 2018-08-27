import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let tabBarController : UITabBarController = UITabBarController();
        let personListController = UINavigationController(rootViewController: PersonListController())
        let homeListController = UINavigationController(rootViewController: HomeListController())
        personListController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        homeListController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 2)
        tabBarController.viewControllers = [personListController, homeListController]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

}

