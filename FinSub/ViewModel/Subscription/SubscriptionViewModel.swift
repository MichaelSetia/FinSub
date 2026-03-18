//
//  SubscriptionViewModel.swift
//  FinSub
//
//  Created by Michael on 12/03/26.
//
import Foundation
import Observation

@Observable
final class SubscriptionViewModel{
    let repository : any SubscriptionRepository
    let brandDetection : BrandDetectorProtocol
    var subscriptions : [SubscriptionModel] = []
    
    var isLoading = false
    
    var messageError : String?
    
    init(repository: any SubscriptionRepository, brandDetection: BrandDetectorProtocol) {
        self.repository = repository
        self.brandDetection = brandDetection
    }

    var monthlyCost : Decimal = 0.0
    
    func updateMonthlyCost() async {
        do {
            monthlyCost = try await repository.calculateMonthlyCost()
        } catch {
            messageError = error.localizedDescription
        }
    }
    
    var nearestRenewals: [SubscriptionModel] {
            subscriptions.sorted { $0.nextPayment < $1.nextPayment }
        }
        
    var furthestRenewals: [SubscriptionModel] {
        subscriptions.sorted { $0.nextPayment > $1.nextPayment }
    }

    func loadSubscription() async {
        isLoading = true
        do{
            subscriptions = try await repository.fetchAllSubscription()
            await updateMonthlyCost()
            NotificationService.shared.rescheduleAllNotifications(for: subscriptions)
            
        }
        catch{
            messageError = error.localizedDescription
        }
        isLoading = false
    }
    
    func buidUrl (for subscription : SubscriptionModel) -> URL? {
        guard let domain = BrandDomainResolve.domain(for: subscription.iconName ?? "netflix")
                else {return nil}
        
        let brand = Brand(domain: domain)
        
        return brandDetection.buildURL(params: brand)
        
    }
    
//    func testNotif() {
//        NotificationService.shared.testNotification()
//    }
//    
    func buildLabelLogoUrl (forBrand brand: String) -> URL? {
        guard let domain = BrandDomainResolve.domain(for: brand )
                else {return nil}
        
        let brand = Brand(domain: domain)
        
        return brandDetection.buildURL(params: brand)
    }
    
    func deleteSubscription(_ subscription: SubscriptionModel) async {
        isLoading = true
        do {
            try await repository.deletesubscription(subscription)
            subscriptions.removeAll { $0.id == subscription.id }
            await updateMonthlyCost()
            NotificationService.shared.cancleNotification(for: subscription)
        }
        catch{
            messageError = error.localizedDescription
        }
        isLoading = false
    }
    
    func addSubscription(name: String, price: Decimal, date: Date, billingCycle: BilingCycle, category: CategoryModel? = nil, iconName: String? = nil, alternativeName : String? = nil ) async {
        isLoading = true
        do {
            let subscription = SubscriptionModel( name: name, price: price, startDate: date, billingCycle: billingCycle, category: category, iconName: iconName, alternativeName: alternativeName)
            try await repository.addSubscription(subscription)
            subscriptions.append(subscription)
            await updateMonthlyCost()
            NotificationService.shared.shceduleNotification(for: subscription)
        }
        catch {
            messageError = error.localizedDescription
        }
        isLoading = false
        
    }
    
    func notificationPermission(){
        NotificationService.shared.requestPermission()
    }
    
    func updateSubscription(_ subscription: SubscriptionModel, name: String, price: Decimal, startDate: Date, billingCycle: BilingCycle, category: CategoryModel?, iconName: String?, alternativeName: String?) async {
        subscription.name = name
        subscription.price = price
        subscription.startDate = startDate
        subscription.billingCycle = billingCycle
        subscription.category = category
        subscription.iconName = iconName
        subscription.alternativeName = alternativeName

        do {
            try await repository.updateSubscription(subscription)
            await updateMonthlyCost()
            NotificationService.shared.cancleNotification(for: subscription)
            NotificationService.shared.shceduleNotification(for: subscription)
        } catch {
            messageError = error.localizedDescription
        }
    }
    
    
}
