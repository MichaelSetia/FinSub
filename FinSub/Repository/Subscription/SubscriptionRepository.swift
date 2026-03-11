//
//  SubscriptionRepository.swift
//  FinSub
//
//  Created by Michael on 11/03/26.
//

import Foundation

@MainActor
protocol SubscriptionRepository {
    func fetchAll() async throws -> [SubscriptionModel]
    func addSubscription(_ subscription : SubscriptionModel) async throws
    func deletesubscription(_ subscription : SubscriptionModel) async throws
    func updateSubscription(_ subscription : SubscriptionModel) async throws
    func fetchById(_ id: UUID) async throws -> SubscriptionModel?
    func fetchUpcomingSubscription (days : Int) async throws -> [SubscriptionModel]
    func calculateMonthlyCost() async throws -> Decimal
}
