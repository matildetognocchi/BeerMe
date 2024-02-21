//
//  BeerModel.swift
//  BeerMeUiKit
//
//  Created by Matilde Tognocchi on 21/2/24.
//

import Foundation

struct BeerModel: Decodable {    
    
    let id: Int
    let uid, brand, name, style: String
    let hop, yeast, malts, ibu: String
    let alcohol, blg: String
}
