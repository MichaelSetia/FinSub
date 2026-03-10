//
//  CategoryModel.swift
//  FinSub
//
//  Created by Michael on 10/03/26.
//

import Foundation
import SwiftData

@Model
final class CategoryModel{
    var id : UUID
    var name : String
    var icon : String
    var color : String
     
    @Relationship(inverse: \SubscriptionModel.category) var subscriptions: [SubscriptionModel] = []
    
    init(id: UUID, name: String, icon: String, color: String) {
        self.id = id
        self.name = name
        self.icon = icon
        self.color = color
    }
    
    
}
