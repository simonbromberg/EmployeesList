## TODO:
* Improve loading / empty / error state UI

## Build tools & versions used
* Swift 5.5
* iOS 15.2
* Xcode 13.2.1 (13C100) 

## Steps to run the app
1. Open BlockEmployees.xcodeproj in Xcode
2. Product > Run from menu bar  

## What areas of the app did you focus on?
* Networking through Swift Concurrency / Combine
* SwiftUI with async images 

## What was the reason for your focus? What problems were you trying to solve?
* Swift Concurrency is a newer, very powerful API that I was eager to use here as a learning exercise for myself. Plus it results in much more concise and more robust networking code. 

## How long did you spend on this project?
* Sunday Jan 23: ~2 h
* Monday Jan 24: ~2 h

## Did you make any trade-offs for this project? What would you have done differently with more time?

## What do you think is the weakest part of your project?

## Did you copy any code or dependencies? Please make sure to attribute them here!
* Used [`CachedImageAsync`](https://github.com/lorenzofiamingo/SwiftUI-CachedAsyncImage) via  Swift Package for simple SwiftUI cahced images in lieu of building this functionality from scratch. Has a pretty simple API and it is lightweight and well-maintained.
* [This raywenderlich.com tutorial](https://www.raywenderlich.com/25013447-async-await-in-swiftui) was a useful starting point for the `EmployeeService` observable object
* Copied code snippet for unit testing async code from [this World Wide Technology article](https://www.wwt.com/article/unit-testing-on-ios-with-async-await)
* Adapted code snippet for key path sorting from [Swift by Sundell](https://www.swiftbysundell.com/articles/the-power-of-key-paths-in-swift/)   

## Is there any other information you’d like us to know?
