## Build tools & versions used
* Swift 5.5
* iOS 15.2
* Xcode 13.2.1 (13C100) 
* Focused on iPhone (works on iPad too) 

## Steps to run the app
1. Open BlockEmployees.xcodeproj in Xcode
2. Product > Run from menu bar  

## What areas of the app did you focus on?
* Networking through Swift Concurrency: wasn't so well-versed in how to accomplish this so it took me a bit longer than following some exiting `URLSession` code but I'm pretty pleased with the outcome.
* Experimenting a bit with SwiftUI and clean architecture with the `EmployeeService` `ObservableObject`.

## What was the reason for your focus? What problems were you trying to solve?
* Swift Concurrency is a new and powerful API that I was eager to use here as a learning exercise for myself. Plus it results in much more concise and more robust networking / state management.
* Similarly, working with SwiftUI is quite interesting it's amazing how it enables much faster development with more concise code that has fewer state-related holes. I still work with UIKit most of the time, but I have been using SwiftUI more and more and I enjoy working with it.
* Could have written this project using UIKit but it would have been less fun for me and a lot bulkier.

## How long did you spend on this project?
* Approximately 5 hours spread over Sunday Jan 23 to Tuesday January 25 2022.

## Did you make any trade-offs for this project? What would you have done differently with more time?
* If necessary, could improve iPad UI — currently there's a lot of unused space because of the wide screen
* Could explore adding more unit tests, such as for the `EmployeeService` and or `Employee` sorting.
* Depending on the requirements, one might want to go with a more customizable image caching solution written from scratch, especially if you wanted to store employees too and enable offline functionality.

## What do you think is the weakest part of your project?
* The loading / empty / error states; I just threw a `Text` `View` at the bottom that showed different states, but the rest of the screen is blank; I liked having all these different states in one place for simplicity but in a real application you'd want to see better usage of the available space.

## Did you copy any code or dependencies? Please make sure to attribute them here!
* Used [`CachedImageAsync`](https://github.com/lorenzofiamingo/SwiftUI-CachedAsyncImage) via  Swift Package for simple SwiftUI cahced images in lieu of building this functionality from scratch. Has a pretty simple API and it is lightweight and well-maintained.
* [This raywenderlich.com tutorial](https://www.raywenderlich.com/25013447-async-await-in-swiftui) was a useful starting point for the `EmployeeService` observable object
* Copied code snippet for unit testing async code from [this World Wide Technology article](https://www.wwt.com/article/unit-testing-on-ios-with-async-await)
* Adapted code snippet for key path sorting from [Swift by Sundell](https://www.swiftbysundell.com/articles/the-power-of-key-paths-in-swift/)   
