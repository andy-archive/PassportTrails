//
//  URL+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/15.
//

import UIKit

extension URL {
    func fetchImage(completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: self) { (data, _, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }.resume()
    }
}
