//
//  Extensions.swift
//  PocketClosetAppTests
//
//  Created by Robbie Tabor on 6/20/24.
//

import Foundation
import SwiftUI

extension UIImage {
    static func createTestImage(withColor color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
