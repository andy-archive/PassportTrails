//
//  UIImageView+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/19.
//

import UIKit
import Kingfisher

extension UIImageView {
    func fetchStampImage(urlString: String, width: CGFloat, height: CGFloat) {
        if urlString.isEmpty {
            self.image = Constants.Image.leafCircle
            return
        }
        
        let size = min(width, height)
        
        let processor = DownsamplingImageProcessor(size: CGSize(width: size, height: size))
        
        guard let url = URL(string: urlString) else { return }
        let resource = KF.ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(
            with: resource,
            options: [
                .processor(processor),
                .transition(.fade(1)),
                .cacheOriginalImage
            ],
            progressBlock: nil) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let imageResult):
                    DispatchQueue.main.async {
                        let sourceImage = imageResult.image
                        self.image = sourceImage.roundedImageWithGloomFilter()
                    }
                case .failure(let error):
                    self.image = Constants.Image.leafCircle
                    print("\(error.localizedDescription)")
                }
            }
    }
}
