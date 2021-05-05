//
//  DetailViewModel.swift
//  Target
//
//  Created by priti.kanaujiya on 05/05/21.
//

import Foundation
class DetailViewModel {
    var infoModel : Product!
    var id: Int!
    var apiRepo = ApiRepo()
    var updateUI:(()-> Void)?
    
    init(id: Int) {
        self.id = id
    }
    
    func getProductInfo() {
        apiRepo.fetchProductInfo(id:String(id), completion: { [unowned self] result in
            switch result {
            case .success(let model) :
                print(model)
                self.infoModel = model
                self.updateUI?()
            case .failure(let error) :
                print(error.localizedDescription)
            }
            
        })
    }
}
