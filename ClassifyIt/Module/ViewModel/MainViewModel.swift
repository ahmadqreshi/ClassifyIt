//
//  MainViewModel.swift
//  ClassifyIt
//
//  Created by Ahmad Qureshi on 20/07/23.
//
import UIKit
import Foundation
import CoreML


class MainViewModel: ObservableObject {
    
    @Published var selectedImageIndex: Int = 0
    @Published var resultLabel: String = ""
    @Published var accuracyLabel: String = ""

    var model: ClassfiyModel! {
        let config = MLModelConfiguration()
        return try? ClassfiyModel(configuration: config)
    }
    
    var images : [String] {
        return ImageAssets.allCases.map { image in
            return image.rawValue
        }
    }
    
    
    func analyzeImage() {
        guard let image = UIImage(named: images[selectedImageIndex]), let resizedImage = image.resizeTo(size: CGSize(width: 224, height: 224)), let buffer = resizedImage.toBuffer() else { return }
        let output = try? model.prediction(image: buffer)
        if let output = output {
            resultLabel = "Result: \(output.classLabel.capitalized)"
            if let accuracy = output.classLabelProbs[output.classLabel] {
                accuracyLabel = "Accuracy: \(String(format: "%0.2f", accuracy * 100))%"
            }

        }
    }
}
