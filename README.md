# GitWood

Github trending repositories app where users view latest trending repositories by last day, week and month with ability to store favourite repositories


### General architecture:

The app uses modular MVVM architecture where API version and Storage can be swapped at any time in the future with minimal refactoring. There are 3 view controllers in the current release

- Trending (main) view Controller
- Favourite View Controller
- Detailed View Controller


### Main View Controller Architecture

* API version Interface currently supports V3 but the design allows implementing V4 when it gets released by Github

* Storage Interface allows swapping different storage options like realm or core data or just temporary cached storage. 

* RepoModel provides interface for swapping codable data model required by different viewModels. At this release both favourite and trending view controllers are using similar model


<img src="https://github.com/nour7/GitWood/blob/master/GitWoodMainViewC.jpeg" width="1200">



### Missing Features:

- Rich user experience, for example showing friendly animated messages when API fails or when requests exceeds limit
- Prohibits making new calls to server if https returns empty on invalid, server out of reach , or no internet connection
- iPad user interface & landscape mode if required
- Setting the limit of dynamic prefetching -- depends on the number of JSON object returned
- List search 
- Authentication (aka Token) to create more than 60 calls limits




### Screenshots:

<img src="https://github.com/nour7/GitWood/blob/master/screens.jpg" width="1200">





