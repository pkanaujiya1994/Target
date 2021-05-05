//
//  ProductListModel.swift
//  Target
//
//  Created by priti.kanaujiya on 04/05/21.
//

import Foundation
class  ProductListModel {
    var response : ProductModelResponse?
    var productList:[Product] = [Product]()
    var apiRepo = ApiRepo()
    var reloadList:(() -> Void)?
    
    func getProductList() {
        apiRepo.fetchProductList(completion: {[weak self] result in
            switch result {
            case .success(let response):
                guard let self = self else { return }
                self.productList.append(contentsOf: response.products)
                self.reloadList?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
}


extension ProductListModel {
    func numberOfRows() -> Int {
        return productList.count
    }
}
