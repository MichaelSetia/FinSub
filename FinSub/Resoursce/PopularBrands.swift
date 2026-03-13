//
//  PopularBrans.swift
//  FinSub
//
//  Created by Michael on 12/03/26.
//

import Foundation

struct PopularBrand{
    let name : String
    let iconName : String
}

struct PopularBrands{
    static let list : [PopularBrand] = [
        PopularBrand(name: "Netflix", iconName: "netflix"),
        PopularBrand(name: "Spotify", iconName: "spotify"),
        PopularBrand(name: "Disney+", iconName: "disney plus"),
        PopularBrand(name: "YouTube", iconName: "youtube"),
        PopularBrand(name: "Apple Music", iconName: "apple music")
    ]
}
