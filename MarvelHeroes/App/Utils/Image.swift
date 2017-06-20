//
//  Image.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/28/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import UIKit

final class Image {
    /// This method loads a image using a specific URL.
    /// - parameters: fromURL: A buffer that represents the URL.
    /// - returns: A UIImage(Optional) with the image.
    static func load(fromURL buffer: String) -> UIImage? {
        // Check if the buffer is a correct URL.
        guard let url: URL = URL(string: buffer) else { return nil }
        // Get the data from the URL.
        guard let data: Data = try? Data(contentsOf: url) else { return nil }
        // Finally return the image using the data loaded from
        // the url.
        return UIImage(data: data)
    }
    
    /// This method loads a image using a specific URL in background.
    /// - parameters: fromURL: A buffer that represetns the URL.
    /// - parameters: callback: A callback used when the load finishes.
    static func loadAsync(fromURL buffer: String,
                          withCallback callback: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .background).async {
            // Check if the buffer is a correct URL.
            guard let url: URL = URL(string: buffer) else { return }
            // Get the data from the URL.
            guard let data: Data = try? Data(contentsOf: url) else { return }
            // Finally return the image using the data loaded from
            // the url.
            callback(UIImage(data: data)!)
        }
    }
}
