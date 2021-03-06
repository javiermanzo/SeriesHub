//
//  UIImageView-Extension.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/24/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

extension UIImageView {

    func grayScale() {
        let context = CIContext(options: nil)
        if let currentFilter = CIFilter(name: "CIPhotoEffectTonal"),
            let image = self.image {
            currentFilter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            if let output = currentFilter.outputImage,
                let cgimg = context.createCGImage(output, from: output.extent) {
                let processedImage = UIImage(cgImage: cgimg)
                self.image = processedImage
            }

        }
    }

}
