# ShootFromTheHip

Hip Shot - photo viewer app

- See popular photos from [Unsplash](https://unsplash.com/)
- View raw photo (original resolution) and photo owner details
- Share image and image link
- Select app appearance (light or dark mode)

## Installation
1. Open `ShootFromTheHip.xcworkspace` on [Xcode](https://developer.apple.com/xcode/)
1. Build and run `ShootFromTheHip` scheme

## Architecture
### MVVM
- ViewModel `PhotoStreamViewModel` requests data from the Unsplash API using `PhotosFetcher` and converts the results to provide a datasource for the View `PhotosStreamViewController`
- Combine framework was used to enable signaling from view model to the view

### Services
- Networking request is handled by `PhotosFetcher`
- `PhotosFetchable` protocol is defined. This allows `PhotosFetcher` to be mocked when writing tests for  `PhotoStreamViewModel`
- `UnsplashAPI` struct is created to define some of the API URL components and request parameter keys. API credentials are also defined here

### Models
- Data structures `Photo`, `PhotoImage`, `User`, `ProfileImage` and `Topic`
- These models conform to `Decodable` so they can be used for transforming the response when fetching photos
- `PhotoStreamData` is an abstraction for the data structures. This struct provides convenient access to photo details like URLs for the full image, small image, user's name, etc. For example, `PhotoStreamCell` can display the preview image by accessing `photoStreamData.previewImageURL` without knowing the internal structure `photo.photoImage.small`
- `Topic` is unused in the current views. Unsplash API provides access to a list of topics (e.g. "Architecture", "Wallpapers", etc). This can be used for future feature development

### Views, ViewModels
- Main view is `PhotoStreamViewController`. The photo stream is visualized with a tableView, each photo is represented by a custom cell  `PhotoStreamCell`
- Other views are  `PhotosDetailsViewController` and `AboutViewController`. Each view has a corresponding view model which provides formatted text or fields to be used in the view
- In `PhotosDetailsViewController` two images are loaded - one is a "regular"-sized image (which is already loaded in the `PhotoStreamView`) and the full-resolution image. This provides a good UX - a photo can be immediately seen by the user (regular size) and then later switched out for the full-resolution version
- Nib files for the view controllers and cell. Main storyboard only has `PhotoStreamViewController` and `AboutViewController`. Ideally, `AboutViewController` should have its own nib file, too
- Dark mode for color sets is included

### Third Party Libraries
- Cocoapods for dependency management
- Pods folder is included in the repository so that the project can be run without additional steps of installing Cocoapods and the libraries used
- **[SDWebImage](https://github.com/SDWebImage/SDWebImage)**: Asynchronous image downloader with cache support, Image display for photos

## Improvements
*Given more time to work on the app*
### Unit Tests
Unit tests for the view models and services

### Architecture
- Coordinator pattern can be implemented. ViewControllers / ViewModels are implementing the screen flow. A coordinator can control which view should be presented next, instead of having this logic in the view controller or view model
- A networking request / photos fetcher wrapper class can be created on top of `PhotosFetcher` (which is based on UnsplashAPI). A protocol can be defined (e.g. `PhotosFetchable`). This wrapper would enable easily switching out the fetcher. For example, switch to another API (Instagram or Flicker)
- When fetching photos, instead of returning a closure for completion, `AnyPublisher <[Photo], PhotosFetcherError>` can be returned (using Combine method `map` to get the response data then decoding to become `[Photo]`)

### UI/UX
- Search for photos based on a keyword
- View photos based on a category
- Loading view (at the bottom of the screen) when loading more photos
- Zoom on a photo
- Transition style when presenting photo details - a better UX could be showing the view as if it has zoomed out from the photo stream, similar to the Apple Photos app
- `QLPreviewController` can be used to display the photo details. Some experimentation is being done the branch `quicklook-experiments`
