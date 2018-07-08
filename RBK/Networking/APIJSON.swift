//
//  APIJSON.swift
//  ParseJSON
//
//  Created by Антон Зайцев on 18.06.2018.
//  Copyright © 2018 Антон Зайцев. All rights reserved.
//

import UIKit

class APIManager {
    
    // Парсим JSON
    func getData(closure: @escaping ([Articles]) -> Void) {
        
        let urlString = "https://newsapi.org/v2/top-headlines?sources=rbc&apiKey=2b77ae3bc1104185a097e01bca536794"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else { return }
            guard let data = data else { return }
            
            do {
                let object = try JSONDecoder().decode(RBK.self, from: data)
                closure(object.articles)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
