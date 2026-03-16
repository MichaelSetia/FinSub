//
//  CategoryViewModel.swift
//  FinSub
//
//  Created by Michael on 12/03/26.
//

import Foundation

@Observable
class CategoryViewModel {
    let repository : any CategoryRepository
    
    var categories: [CategoryModel] = []
    
    var isLoading: Bool = false
    
    var messageError: String?
    
    init(repository: any CategoryRepository) {
        self.repository = repository

    }
    
    func loadCategory() async {
        isLoading = true
        messageError = nil
        do{
            categories = try await repository.fetchAllCategory()
        }
        catch{
            messageError = error.localizedDescription
        }
        isLoading = false
    }
    
    func getOrCreateCategory(name: String) async -> CategoryModel? {
        isLoading = true
        defer { isLoading = false }
        do {
            let allCategories = try await repository.fetchAllCategory()
            if let existing = allCategories.first(where: { $0.name == name }) {
                return existing
            } else {
                let newCategory = CategoryModel(name: name)
                try await repository.addCategory(newCategory)
                return newCategory
            }
        } catch {
            messageError = error.localizedDescription
            return nil
        }
    }
    
    
}
