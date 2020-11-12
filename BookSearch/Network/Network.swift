//
//  Network.swift
//  BookSearch
//
//  Created by Bona Deny S on 11/8/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import Foundation

class Network {
    let url = "https://www.googleapis.com/books/v1/volumes?q="
    
    func fetch<T: Decodable>(keyword:String, completion: @escaping (Result<T, Error>) -> ()) {
        URLSession.shared.dataTask(with: URL(string: url+keyword.replacingOccurrences(of: " ", with: "%20"))!) { (data, resp, err) in
            DispatchQueue.main.async {
                
                if let err = err {
                    completion(.failure(err))
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let obj = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(obj))
                }catch let jsonErr {
                    print("Failed to decode json: ", jsonErr)
                    completion(.failure(jsonErr))
                }
            }
        }.resume()
    }
}
