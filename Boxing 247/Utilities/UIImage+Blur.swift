//
//  UIImage+Blur.swift
//  Boxing 247
//
//  Created by Omar  on 07/08/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

extension UIImage {
    
    func blurEffect(input:  UIImage) -> UIImage  {
        let context = CIContext(options: nil)
        var image = input
        
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        let beginImage = CIImage(image: image)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(5, forKey: kCIInputRadiusKey)
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
        
        let output = cropFilter!.outputImage
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        image = processedImage
        return processedImage
    }
    
    class func takeScreenshot(view: UIView) -> UIImage? {

        // Create screenshot
        UIGraphicsBeginImageContext(view.bounds.size)

        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        print("Taking Screenshot")

        UIGraphicsEndImageContext()
        return screenshot
    }
    
}

extension UIImageView {
    func downloadImageFrom(link: String, contentMode: UIView.ContentMode) {
        
        URLSession.shared.dataTask(with: URL(string:link)!){ data, response, error in
            
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }.resume()
    }
}
