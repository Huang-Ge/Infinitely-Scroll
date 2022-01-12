//
//  Date.swift
//  Pagination Tutorial
//
//  Created by Ge Huang on 2022/1/9.
//

import Foundation

struct selfDefinedDate: Decodable {
    let year: Int
}

struct monthViewData {
    let month: String
    let days: [String]
}
