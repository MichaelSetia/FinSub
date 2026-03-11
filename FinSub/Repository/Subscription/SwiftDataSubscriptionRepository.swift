//
//  SwiftDataSubscriptionRepository.swift
//  FinSub
//
//  Created by Michael on 11/03/26.
//

import Foundation
import SwiftData

struct SwiftDataSubscriptionRepository : SubscriptionRepository{

    
    private let modelContex : ModelContext
    init(modelContex: ModelContext) {
        self.modelContex = modelContex
    }
    
    func fetchUpcomingSubscription(days: Int) async throws -> [SubscriptionModel] {
        let all = try await fetchAllSubscription()
        let now = Date()
        let endSubs = Calendar.current.date(byAdding: .day,value: days, to: now)
        
        return all.filter{ subs in
            subs.nextPayment<=endSubs!
        }
    }
    
    func calculateMonthlyCost() async throws -> Decimal {
        let all = try await fetchAllSubscription()
    
        return all.reduce(Decimal(0)) { (result,sub) in
            result + sub.monthlyCost
        }
    }
    
    func fetchAllSubscription() async throws -> [SubscriptionModel] {
        let desctiptor = FetchDescriptor<SubscriptionModel>()
        return try modelContex.fetch(desctiptor)
    }
    
    func addSubscription(_ subscription: SubscriptionModel) async throws {
        modelContex.insert(subscription)
        try modelContex.save()
    }
    
    func deletesubscription(_ subscription: SubscriptionModel) async throws {
        modelContex.delete(subscription)
        try modelContex.save()
    }
    
    func updateSubscription(_ subscription: SubscriptionModel) async throws {
        try modelContex.save()
    }
    
    func fetchById(_ id: UUID) async throws -> SubscriptionModel? {
        let predicate = #Predicate<SubscriptionModel>{ $0.id == id}
        var descriptor = FetchDescriptor<SubscriptionModel>( predicate: predicate)
        descriptor.fetchLimit = 1
        return try modelContex.fetch(descriptor).first
    }
    
    
}

