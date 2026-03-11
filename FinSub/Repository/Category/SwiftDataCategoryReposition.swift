//
//  SwiftDataCategory.swift
//  FinSub
//
//  Created by Michael on 11/03/26.
//

import SwiftUI
import Foundation
import SwiftData

struct SwiftDataCategoryReposition : CategoryRepository {
    
    
    private var modelContex : ModelContext
    init(modelContex: ModelContext) {
        self.modelContex = modelContex
    }

    func fetchAllCategory() async throws -> [CategoryModel] {
        let descriptor = FetchDescriptor<CategoryModel>()
        return try modelContex.fetch(descriptor)
    }
    
    func addCategory(_ category: CategoryModel) async throws {
        modelContex.insert(category)
        try modelContex.save()
    }
    
    func deleteCategory(_ category: CategoryModel) async throws {
        modelContex.delete(category)
        try modelContex.save()
    }
    
    func updateCategory(_ category: CategoryModel) async throws {
        try modelContex.save()
    }
    
    
}

