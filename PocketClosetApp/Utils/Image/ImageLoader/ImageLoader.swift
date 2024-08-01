//
//  File.swift
//  PocketCloset
//
//  Created by Robbie Tabor on 2/20/24.
//

import Foundation
import SwiftUI

struct ImageLoader {
   static func loadImageFromDisk(withName fileName: String) -> UIImage? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
       let fileURL = documentDirectory?.appendingPathComponent(fileName)
        
        guard let url = fileURL, let imageData = try? Data(contentsOf: url) else {
            print("Error loading image from disk")
            return nil
        }
        
        return UIImage(data: imageData)
    }
}
