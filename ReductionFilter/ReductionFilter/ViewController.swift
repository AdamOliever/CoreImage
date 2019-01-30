//
//  ViewController.swift
//  ReductionFilter
//
//  Created by adam on 2019/1/23.
//  Copyright © 2019 adam. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
   
    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let filterImage = loadImage()
        self.imageView.image = convertToNSImage(ciImage: filterImage)
        //let filterRect:CIVector = CIVector(cgRect: CGRect(x: 200, y: 2002, width: 200, height: 200))
        let filterRect:CIVector = CIVector(cgRect: CGRect(x: 0, y: 0, width: 2400, height: 2400))
        let averageImageFilter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey:filterImage,
                                                                              kCIInputExtentKey:CIVector(cgRect: filterImage.extent)])
        
        self.imageView.image = convertToNSImage(ciImage: (averageImageFilter?.outputImage)!)
    }

    
    func loadImage() -> CIImage {
       
        guard let pathStr:String = Bundle.main.path(forResource: "1", ofType: ".jpg", inDirectory: "Image") else {
            fatalError("Could not access the path")
        }
        
        let pathUrl:URL = URL(fileURLWithPath: pathStr)
        
        
        
        //decode the image
        let imageSource:CGImageSource = CGImageSourceCreateWithURL(pathUrl as CFURL, nil)!
        
        let cgImage:CGImage = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)!
        
        let ciImage:CIImage = CIImage(cgImage: cgImage)
        
        return ciImage
        
        
    }
    
    func convertToNSImage(ciImage:CIImage) -> NSImage {
        let imageRep:NSCIImageRep = NSCIImageRep(ciImage: ciImage)
        
        let newImage:NSImage = NSImage(size: imageRep.size)
        
        newImage.addRepresentation(imageRep)
        
        return newImage
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

