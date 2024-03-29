//
//  UIImage+.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/16.
//

import UIKit

extension UIImage {
    func roundedImageWithGloomFilter() -> UIImage? {
        let size = min(self.size.width, self.size.height)
        let cgSize = CGSize(width: size, height: size)
        let renderer = UIGraphicsImageRenderer(size: cgSize)
        
        return renderer.image { context in
            let roundedRect = CGRect(x: 0, y: 0, width: size, height: size)
            let clipPath = UIBezierPath(roundedRect: roundedRect, cornerRadius: size / 2)
            clipPath.addClip()
            
            guard let ciImage = CIImage(image: self),
                  let filter = CIFilter(name: "CIGloom")
            else { return }
            
            filter.setDefaults()
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            filter.setValue(size / 40, forKey: "inputRadius")
            filter.setValue(Constants.Design.gloomFilterIntensityRatio, forKey: "inputIntensity")
            
            guard let outputImage = filter.outputImage,
                  let cgImage = CIContext().createCGImage(outputImage, from: ciImage.extent)
            else { return }
            
            let filteredImage = UIImage(cgImage: cgImage)
            filteredImage.draw(in: roundedRect)
            
            context.cgContext.setStrokeColor(UIColor.label.cgColor)
            context.cgContext.setLineWidth(2.0)
            context.cgContext.addEllipse(in: roundedRect.offsetBy(dx: 0.0, dy: 0.0))
            context.cgContext.strokePath()
        }
    }
}
