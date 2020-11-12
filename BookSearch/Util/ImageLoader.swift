//
//  ImageView.swift
//  BookSearch
//
//  Created by Bona Deny S on 11/8/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    @Published var loaded = UIImage()
    @Published var loading = false
    
    init(from url: String?, placeholder: String) {
        self.loaded = UIImage(named: placeholder)!
        guard let url = url else { return }
        
        guard let imageURL = URL(string: url) else { return }
        
        loading.toggle()
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.loaded = image ?? UIImage(named: placeholder)!
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    self.loading.toggle()
                }
            }
        }
    }
}
