//
//  CategoryRepository.swift
//  FinSub
//
//  Created by Michael on 11/03/26.
//

import Foundation

@MainActor
protocol CategoryRepository {
    func fetchAllCategory() async throws -> [CategoryModel]
    func addCategory(_ category: CategoryModel) async throws
    func deleteCategory(_ category: CategoryModel) async throws
    func updateCategory(_ category: CategoryModel) async throws
    func fetchCategorybyName(name: String) async throws -> [CategoryModel]
    
}
