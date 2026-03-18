//
//  NotificationService.swift
//  FinSub
//
//  Created by Michael on 17/03/26.
//

import Foundation
import UserNotifications


class NotificationService :  NSObject, UNUserNotificationCenterDelegate{
    static let shared = NotificationService()
    override 
    private init() {
        super.init( )
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(
           _ center: UNUserNotificationCenter,
           willPresent notification: UNNotification,
           withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
       ) {
           completionHandler([.banner, .sound])
       }
    
    func requestPermission(){
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]
        ){ granted, error in
            if granted {
                print("Permission granted.")
            } else{
                print("Permission denied.")
            }
        }
        
    }
    
    func shceduleNotification(for subscription: SubscriptionModel){
        let nextDate = subscription.nextPayment
        guard let reminderDate = Calendar.current.date(byAdding: .day, value: -1, to: nextDate),
              reminderDate > Date() else {
            print("Reminder date not valid for \(subscription.name)")
            return
        }

        let content = UNMutableNotificationContent()
        content.title = "Renewal Reminder"
        content.body = "Your subscription to \(subscription.name) is about to renew."
        content.sound = .default

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminderDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: subscription.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error)")
            } else {
                print("Notification scheduled for \(subscription.name) at \(reminderDate)")
            }
        }
}
    
    
    func rescheduleAllNotifications(for subscriptions: [SubscriptionModel]) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        for sub in subscriptions {
            shceduleNotification(for: sub)
        }
    }
    
    func cancleNotification (for subscription: SubscriptionModel){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [subscription.id.uuidString])
    }
    
//    func testNotification() {
//        // Minta izin dulu
//        requestPermission()
//        
//        // Beri sedikit jeda agar izin selesai (opsional, karena requestPermission async)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            let content = UNMutableNotificationContent()
//            content.title = "Test Notification"
//            content.body = "Ini notifikasi 10 detik"
//            content.sound = .default
//
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
//            let request = UNNotificationRequest(identifier: "test-notification", content: content, trigger: trigger)
//
//            UNUserNotificationCenter.current().add(request) { error in
//                if let error = error {
//                    print(" Error adding test notification: \(error.localizedDescription)")
//                } else {
//                    print(" Test notification scheduled")
//                    
//                    // Cek pending requests
//                    UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
//                        print(" Pending after add: \(requests.map { $0.identifier })")
//                    }
//                }
//            }
//        }
//    }
}
