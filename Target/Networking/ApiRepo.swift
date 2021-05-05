//
//  ApiRepo.swift
//  Target
//
//  Created by priti.kanaujiya on 04/05/21.
//

import Foundation

final class ApiRepo {
    let remoteServices: ApiServices
    
    init(remoteServices: ApiServices = .init()) {
        self.remoteServices = remoteServices
    }
    
    func fetchProductList( completion:@escaping (Result<ProductModelResponse, Error>) -> Void) {
        remoteServices.getProductList(completion:completion)
    }
    
    func fetchProductInfo(id: String,  completion:@escaping (Result<Product, Error>) -> Void) {
        remoteServices.getProductDetail(id: id, completion: completion)
    }
    
}
