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
}
