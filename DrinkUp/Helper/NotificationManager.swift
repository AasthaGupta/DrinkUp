//
//  NotificationManager.swift
//  Drink up
//
//  Created by Gupta, Aastha on 8/23/20.
//  Copyright © 2020 Gupta, Aastha. All rights reserved.
//

import Foundation
import UserNotifications

internal class NotificationManager: NSObject {

    enum actionIdentifiers: String {
        case done = "DONE_ACTION"
    }

    enum categoryIdentifers: String {
        case waterReminder = "WaterReminder"
    }

    static var shared: NotificationManager = NotificationManager()

    private var center: UNUserNotificationCenter = UNUserNotificationCenter.current()

    private override init() {
        super.init()

        self.center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, _) in
            if granted {
                self.center.removeAllDeliveredNotifications()
                print("Notification permission granted by user")
                self.setup()
            }
        }
    }

    func handleNotification() {

    }

    private func setup() {
        self.center.delegate = self
        self.setupNotificationCategories()
        self.setupWaterReminderNotification()
    }

     private func setupWaterReminderNotification() {
        let content: UNMutableNotificationContent = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Drink a glass of water"
        content.categoryIdentifier = NotificationManager.categoryIdentifers.waterReminder.rawValue
        content.sound = .default

//        var dateComponents: DateComponents = DateComponents()
//        dateComponents.hour = 21
//        dateComponents.minute = 57
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: true)

//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: "WaterReminderNotificationRequest", content: content, trigger: trigger)
        self.center.add(request) { (error) in
            if error != nil {
                print("Error adding notification request \(String(describing: error))")
            } else {
                print("Notification request added successfully!")
            }
        }
    }

    private func setupNotificationCategories() {
        // setup water reminder category
        let doneAction = UNNotificationAction(identifier: NotificationManager.actionIdentifiers.done.rawValue,
                                                     title: "Done",
                                                     options: UNNotificationActionOptions(rawValue: 0))
        let waterReminderCategory = UNNotificationCategory(identifier: NotificationManager.categoryIdentifers.waterReminder.rawValue,
                                                          actions: [doneAction],
                                                          intentIdentifiers: [],
                                                          options: UNNotificationCategoryOptions(rawValue: 0))

        center.setNotificationCategories([waterReminderCategory])

    }

}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.content.categoryIdentifier == NotificationManager.categoryIdentifers.waterReminder.rawValue {
            switch response.actionIdentifier {
            case NotificationManager.actionIdentifiers.done.rawValue, UNNotificationDefaultActionIdentifier:
                DataManager.shared.save()
                print("Notification received")
            default:
                break
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.content.categoryIdentifier == NotificationManager.categoryIdentifers.waterReminder.rawValue {
            // TODO: show the reminder to drink water in app itself
            completionHandler(.sound)
        }
    }

}
