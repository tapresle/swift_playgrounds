//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        var text = randomString(length: 2048)
        for _ in 1...2048 {
    //text += String(Int.random(in: 0...9))
    text += ""
        }
        let image = generateQRCode(from: text)
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        self.view = view
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.isoLatin1)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("L", forKey: "inputCorrectionLevel")
            let transform = CGAffineTransform(scaleX: 2, y: 2)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=.,/?"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
