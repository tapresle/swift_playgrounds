//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white

        var pixels = [UIColor]()

        let firstRandomColor = UIColor(red: CGFloat(randomUInt8()) / 255.0, green: CGFloat(randomUInt8()) / 255.0, blue: CGFloat(randomUInt8()) / 255.0, alpha: 1.0)
        let secondRandomColor = UIColor(red: CGFloat(randomUInt8()) / 255.0, green: CGFloat(randomUInt8()) / 255.0, blue: CGFloat(randomUInt8()) / 255.0, alpha: 1.0)

        for _ in 0 ..< 5 {
            for _ in 0 ..< 3 {
                pixels.append(randomUInt8(start: 0, end: 1) == 0 ? firstRandomColor : secondRandomColor)
            }
            pixels.append(pixels[pixels.count - 2]) // Mirror "pixel" in 2nd spot of row
            pixels.append(pixels[pixels.count - 4]) // Mirror "pixel" in 1st spot of row
        }
        
        let subview = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        for pixelIndex in 0 ... pixels.count - 1 {
            let row = pixelIndex % 25 / 5
            let pixelView = UIView(frame: CGRect(x: pixelIndex % 5 * 20, y: row * 20, width: 20, height: 20))
            pixelView.backgroundColor = pixels[pixelIndex]
            subview.addSubview(pixelView)
        }
        let imageView = UIImageView(image: UIImage.imageFromView(subview))
        view.addSubview(imageView)
        
        self.view = view
    }
}

func randomUInt8(start: Int = 0, end: Int = 255) -> UInt8 {
    return UInt8(Int.random(in: start ... end));
}

extension UIImage {
    class func imageFromView(_ view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0)
        defer { UIGraphicsEndImageContext() }
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
