//
//  FinSubApp.swift
//  FinSub
//
//  Created by Michael on 10/03/26.
//

import SwiftUI
import SwiftData

@main
struct FinSubApp: App {


    var body: some Scene {
        WindowGroup {
            ContentView()
               
        }
        .modelContainer(for:[SubscriptionModel.self, CategoryModel.self])
    }
}
