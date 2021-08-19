
## Swift-MVVM-Programattically-UserInterface-Demo
Sample iOS application in Swift presenting usage of MVVM pattern with cutome user interface without using storyboard and loading images from backend with maintained aspect ratio.

## Prerequisites
Xcode
It requires the Xcode 11 and above.
Support: iPhone only


## Application Features
- User Interface created programmatically without using storyboard
- Reddit List with sample data fetched from mocked backend
- Loading Images asynchronously
- Unit Test cases with mock data
- Images displaying according to width and height with maintained aspect ratio
- Scroll Infinitely while loading the list

## Architecture
This project is POC for MVVM pattern where:
- View is represented by `UIViewController` designed programatticallly
- ViewModel interacts with View controller by using input and output protocol
- ViewModel interact with respository for fetching data from backend.
- Network service class interact with backend and pass data to repository.
