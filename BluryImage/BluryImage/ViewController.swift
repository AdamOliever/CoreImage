//
//  ViewController.swift
//  BluryImage
//
//  Created by adam on 2019/1/23.
//  Copyright © 2019 adam. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    @IBOutlet weak var imageView: NSImageView!
    var processImage:CIImage!
    var bluryFilter:CIFilter!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupImageView(with: loadImage())
        
        self.bluryFilter = CIFilter(name: "CIGaussianBlur", parameters:[kCIInputImageKey:cgImagConvertCIImage(image: loadImage()),
                                                                     kCIInputRadiusKey:25])
    
        let bluryImage:CIImage = self.bluryFilter.outputImage!
        
        self.imageView.image = convertCIImageToNSImage(image: bluryImage)
    }

    
    
    func setupImageView(with image:CGImage) -> Void {
        
        let displayImage:NSImage = NSImage(cgImage: image, size: NSMakeSize(CGFloat(image.width), CGFloat(image.height)))
        
        self.imageView.image = displayImage
    }
    
    func convertCIImageToNSImage(image:CIImage) -> NSImage {
        let imageRep:NSCIImageRep = NSCIImageRep(ciImage: image)
        
        let newImage:NSImage = NSImage(size: imageRep.size)
        
        newImage.addRepresentation(imageRep)
      
        return newImage
    }
    
    func cgImagConvertCIImage(image:CGImage) -> CIImage {
        
        return CIImage(cgImage: image)
    }
    
    func loadImage() -> CGImage {
        guard let imagePath:String = Bundle.main.path(forResource: "1", ofType: ".jpg", inDirectory: "Image") else {
            fatalError("Error")
        }
        
        let imageURL:URL = URL(fileURLWithPath: imagePath)
        
        //Image IO
        let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, nil)
        
        let cgImage = CGImageSourceCreateImageAtIndex(imageSource!, 0, nil)!
        
        return cgImage
        
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

