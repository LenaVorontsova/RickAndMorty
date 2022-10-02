//
//  AppDelegate.swift
//  RickAndMortyApp
//
//  Created by Admin on 02.08.2022.
//

import UIKit
import CoreData
import FirebaseCore
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var startService: StartService?
    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        startService = StartService(window: window)
        FirebaseApp.configure()
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        return true
    }

    // MARK: - Core Data stack

    func applicationWillTerminate(_ application: UIApplication) {
            self.saveContext()
        }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RickAndMorty")
        container.loadPersistentStores(completionHandler: { (_, error) in
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
