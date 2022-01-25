//
//  EmployeeImage.swift
//  BlockEmployees
//
//  Created by Simon Bromberg on 2022-01-24.
//

import CachedAsyncImage
import SwiftUI

struct EmployeeImage: View {
    let urlString: String?

    var body: some View {
        CachedAsyncImage(
            url: urlString.flatMap { URL(string: $0) }
        ) { phase in
            if let image = phase.image {
                image.employee
            } else if phase.error != nil {
                Image("placeholder").employee
            } else {
                ProgressView().padding()
            }
        }
    }
}

extension Image {
    var employee: some View {
        resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .shadow(radius: 10)
            .overlay(
                Circle().stroke(
                    Color.secondary,
                    lineWidth: 2
                )
            )
    }
}

struct EmployeeImage_Previews: PreviewProvider {
    private static let testURLString = "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg"

    static var previews: some View {
        Group {
            EmployeeImage(
                urlString: Self.testURLString
            )
                .previewDisplayName("Image from URL")
            EmployeeImage(urlString: nil)
                .previewDisplayName("Placeholder")
        }
        .previewLayout(.fixed(width: 100, height: 100))
    }
}
