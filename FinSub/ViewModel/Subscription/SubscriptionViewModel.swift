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
    
    func loadSubscription() async {
        isLoading = true
        do{
            subscriptions = try await repository.fetchAllSubscription()
            
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
        }
        catch{
            messageError = error.localizedDescription
        }
        isLoading = false
    }
    
    func addSubscription(name: String, price: Int, date: Date, billingCycle: BilingCycle, category: CategoryModel? = nil, iconName: String? = nil ) async {
        isLoading = true
        do {
            let subscription = SubscriptionModel( name: name, price: Decimal(price), startDate: date, billingCycle: billingCycle, category: category, iconName: iconName)
            try await repository.addSubscription(subscription)
            subscriptions.append(subscription)
        }
        catch {
            messageError = error.localizedDescription
        }
        isLoading = false
        
    }
}
