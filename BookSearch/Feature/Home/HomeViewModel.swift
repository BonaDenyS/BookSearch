//
//  HomeViewModel.swift
//  BookSearch
//
//  Created by Bona Deny S on 11/7/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModel: ObservableObject {
    
    @Published var books = [Item]()
    
    func fetching(_ keyword: String) {
        Network().fetch(keyword: keyword) { (results: Result<Raw, Error>) in
            switch results {
                case .success(let raw) :  self.books = raw.items as [Item]
                case .failure(let err) :  print("Failed fetching HomeView because ", err)
            }
           
        }
    }
}
