//
//  ApiServices.swift
//  Target
//
//  Created by priti.kanaujiya on 04/05/21.
//

import Foundation

import Foundation
final class ApiServices {
    
    private let session: URLSession
  
    init() {
        self.session = URLSession.shared
    }
    
    
    func getProductList(completion: @escaping (Result<ProductModelResponse, Error>) -> Void) {
        let baseUrl = URL(string: ApiRequestList.listApi)
        print("Api request for \(baseUrl)")
        guard let url = baseUrl else {
            print("Not able to create specific url")
            return
        }
        makeRequest(url: url, completionHandler: completion)
    }
    
    func getProductDetail(id: String, completion: @escaping(Result<Product, Error>) -> Void) {
        let fetchingStr = "\(ApiRequestList.listApi)/\(id)"
        let baseUrl = URL(string: fetchingStr)
        print("Api request for \(baseUrl)")
        guard let url = baseUrl else {
            print("Not able to create specific url")
            return
        }
        makeRequest(url: url, completionHandler: completion)
    }
    
    //Pass url and fetch the api response as a generic
    private func makeRequest<Response: Codable>(url: URL, completionHandler: @escaping (Result<Response, Error>) -> Void) {
        session.dataTask(with: url) { (data,_,error) in
            if let err = error {
                completionHandler(.failure(err))
            }
            
            guard let data = data else {
                completionHandler(.failure(RuntimeError("Unable to make request")))
                return
            }
            
            if let modelResponse = parseJSON(from: data, to: Response.self) {
                completionHandler(.success(modelResponse))
            } else if let model = parseJSON(from: data, to: NotFoundError.self){
                completionHandler(.failure(model))
            } else {
                completionHandler(.failure(RuntimeError("There was an error while mapping the network response")))
            }
            
        }.resume()
    }
    
  
}
private func parseJSON<Response: Codable>(from data: Data,to _: Response.Type ) -> Response? {
     do {
         return try JSONDecoder().decode(Response.self, from: data)
     } catch {
         print(error)
     }
    return nil
 }



struct RuntimeError: LocalizedError {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    var errorDescription: String? {
        return message
    }
}

struct NotFoundError: Codable, LocalizedError {
    var message: String
    var code: String
}


