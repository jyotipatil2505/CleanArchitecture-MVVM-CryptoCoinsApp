# CryptoFinder App

The **CryptoFinder App** is a UIKit-based Mobile application designed to create a Crypto Coin List application that displays a list of cryptocurrency coins, allowing users to filter and search through the list using various options.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [API Integration](#api-integration)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)
- [Contact](#contact)

## Overview

The CryptoFinder app aims to simplify how users consume news by aggregating articles from multiple sources and presenting them in an easy-to-navigate format. The application includes essential features such as bookmarking articles for offline reading and filtering news by category to enhance user experience.

## Features

1. **Crypto Coin List**:
   - Displays a comprehensive list of crypto coins.
   - Each coin view includes:
     - **Name**
     - **Symbol**
     - **Type**
   - Disabled view for coins that are not active.

2. **Filter Functionality**:
   - Users can apply multiple filters simultaneously:
     - Filter by `is_active`.
     - Filter by `type`.
     - Filter by `is_new`.

3. **Search Functionality**:
   - Search for coins by `name` or `symbol`.

## Screenshots

#### CryptoCoinList Screen
<img src="https://github.com/jyotipatil2505/CleanArchitecture-MVVM-CryptoCoinsApp/blob/main/CryptoCoin/Screenshots/CryptoCoinListScreen.png" alt="Home Screen" width="240" />

#### Filter View
<img src="https://github.com/jyotipatil2505/CleanArchitecture-MVVM-CryptoCoinsApp/blob/main/CryptoCoin/Screenshots/FilterView.png" alt="Article Detail Screen" width="240" />

#### Searched CryptoCoinList Screen
<img src="https://github.com/jyotipatil2505/CleanArchitecture-MVVM-CryptoCoinsApp/blob/main/CryptoCoin/Screenshots/SearchedCryptoCoinList.png" alt="Article Detail Screen" width="240" />


## Architecture

This project follows the **Clean Architecture - Model-View-ViewModel** architecture pattern, which helps keep the code modular, maintainable, and testable.

- **Presentation Layer**: Manages the user interface (UI) and handles user interactions.
  
- **Domain Layer**: Contains the core business logic and is independent of any framework or technology.
  
- **Data Layer**: Responsible for data management and access from various sources (network, local storage).

- **Core Layer**: Contains reusable utilities and application-wide resources.

- **Infrastructure Layer**: Provides foundational services like network communication and configuration.


## Folder Structure

- 
  ```bash
  
  CryptoCoin/
  |
  ├── Screenshots/
  │   ├── Bookmarks.png                                     # Displays the list of bookmarked articles, allowing users to easily access their saved content.
  │   ├── TopHeadlines.png                                  # Shows the screen displaying the top headlines, presenting an overview of the latest articles available in the news
  │   └── ArticleDetails.png                                # Illustrates the detailed view of an article, providing users with in-depth information and content related to the selected news item.
  ├── Application/                                          # Core presentation layer of the application, handling UI logic and user interaction.
  │   ├── ViewModels                                        # Contains logic to manage the UI data.
  │   │   ├── CryptoListViewModel.swift                     # Manages the logic for fetching and preparing crypto coin data for display in the UI.
  │   ├── ViewControllers                                   # Controls the views by connecting the UI to the underlying logic.
  │   │   ├── CoinListViewController+Extension.swift        # Extensions for the CoinListViewController to handle TableView and Search related functionalities.
  │   │   ├── CoinListViewController.swift                  # Primary view controller for displaying the list of crypto coins.
  │   ├── Views                                             # Displays list of articles
  │   │   ├── FilterView.swift                              # UI component to apply multiple filters to the crypto coin list.
  │   │   ├── LoaderView.swift                              # Displays a loading animation while data is being fetched.
  │   │   ├── CryptoTableViewCell.swift                     # Custom table cell to display coin details (name, symbol, type) with appropriate styles.
  │   │   ├── NoDataView.swift                              # Displays a placeholder when there is no data to show.
  ├── Domain/                                               # Contains business logic, which is independent of frameworks and UI.
  │   ├── UseCases                                          # Encapsulates specific business logic.
  │   │   ├── GetCryptoCoinsUseCase.swift                   # Handles the use case of fetching a list of crypto coins from data sources.
  │   ├── Repositories                                      # Defines interfaces for data operations.
  │   │   ├── CryptoRepositoryProtocol.swift                # Outlines the methods for interacting with crypto coin data sources (local or network).
  │   ├── Entities                                          # Represents core application models.
  │   │   ├── CryptoCoinModel.swift                         # Data model defining the structure of a crypto coin entity.
  ├── Data/                                                 
  │   ├── DataSources                                       
  │   │   ├── Local                                         # Handles local storage of crypto coin data.
  │   │   │   ├── Mappers                                   # Converts data between local and domain models.
  │   │   │   │   ├── CryptoCoinModel+RealmMapper.swift     # Maps between CryptoCoinModel and Realm model.
  │   │   │   │   ├── CryptoCoinRealm+DomainMapper.swift    # Maps between Realm model and domain model.
  │   │   │   ├── Models                                    # Contains Realm database models for storing crypto coin data.
  │   │   │   ├── CryptoLocalDataSource.swift               # Protocol for local data operations.
  │   │   │   ├── CryptoLocalDataSourceImpl.swift           # Implementation of local data operations.
  │   │   │   ├── LocalStorageError.swift                   # Defines errors related to local storage operations.
  │   │   ├── Network                                       # Handles fetching data from remote sources.
  │   │   │   ├── CryptoNetworkDataSource.swift             # Protocol for network operations.
  │   │   │   ├── CryptoNetworkDataSourceImpl.swift         # Implementation of network operations.
  │   ├── Repositories                                      # Concrete implementations of data repositories.
  │   │   ├── CryptoRepository.swift                        # Implements methods to fetch and manage crypto coin data from local or network sources.
  ├── Core/                                                 # Contains shared resources and utility classes.
  │   ├── Constants.swift                                   # Stores app-wide constants like FilterOptions, Colors etc.
  │   ├── Extensions.swift                                  # Adds extensions to existing classes for added functionality.
  │   ├── Helpers.swift                                     # Utility functions to simplify common tasks.
  │   ├── Reachability.swift                                # Handles network connectivity checks.
  ├── Infrastructure/                                       
  │   ├── Network                                           # Manages API calls and network configurations.
  │   │   ├── Protocols                                     
  │   │   │   ├── APIServiceProtocol.swift                  # Protocol for network service operations.
  │   │   │   APIConfig.swift                               # Configuration for Base Url, Api Keys.
  │   │   │   APIManager.swift                              # Manages network requests and responses.
  │   │   │   Endpoints.swift                               # Defines API endpoints.
  │   │   │   HTTPMethod.swift                              # Enum for HTTP request methods (GET, POST, etc.).
  │   │   │   NetworkError.swift                            # Defines network-related errors.
  │   │   │   APIService.swift                              # Implements network service operations.
  |── Resources/
  │   ├── Main.storyboard                                   # Primary storyboard for the application UI.
  │   ├── Assets.xcassets                                   # Images and icons used in the app.
  │   ├── LaunchScreen.storyboard                           # Splash screen shown at app launch.
  │   ├── Info.plist                                        # Configuration file for app metadata.
  ├── CryptoCoinTests/
  │   ├── Domain                                            # Domain Layer for Unit Test Cases
  │   │   ├── GetCryptoCoinsUseCaseTests.swift              # Tests for GetCryptoCoinsUseCase
  │   ├── Presentation                                      # Presentation Layer for Unit Test Cases
  │   │   ├── CryptoListViewModelTests.swift                # Tests for CryptoListViewModel.
  │   ├── Mocks                                             # Mock Layer For Unit Test Cases
  │   │   ├── MockGetCryptoCoinsUseCase.swift               # Mock implementation of the use case for testing.
  │   │   ├── MockCryptoRepository.swift                    # Mock repository for testing data operations.
  ├── CryptoCoin.xcworkspace                                # Xcode project
  ├── README.md                                             # Project documentation

  

## Installation

To set up the CryptoFinder App on your local machine, follow these steps:

### Prerequisites

- Ensure you have the latest version of Xcode installed.
- Clone the repository to your local machine.

### Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/jyotipatil2505/CleanArchitecture-MVVM-CryptoCoinsApp.git

2. Navigate into the project directory:

   ```bash
   cd CleanArchitecture-MVVM-CryptoCoinsApp

3. Open the Xcode project:

   ```bash
   open CryptoCoin.xcworkspace

4. Run the app on a simulator or a physical device by pressing Cmd + R.


## API Integration

The CryptoFinder app utilizes the [NewsAPI](https://newsapi.org/) to fetch articles. This integration allows the app to display real-time news updates across various categories.

### Getting Started with NewsAPI

1. **Sign Up for an API Key**: 
   - Visit [NewsAPI.org](https://newsapi.org/) and create an account to obtain your API key. This key is essential for making requests to the API.

2. **Add Your API Key**: 
   - Once you have your API key, open the `APIConfig.swift` file in your project.
   - Replace the placeholder API key with your actual key:


   ```swift
   static let apiKey: String = "YOUR_API_KEY"

### Example API Request

The CryptoFinder app makes use of the `NewsRepository` class to handle requests to the NewsAPI. 

- Below is an example of how to fetch the top headlines and handle the response.:

   ```swift
   let endpoint = category == .all || category == nil ? Endpoint.topHeadlines() : Endpoint.topHeadlines(category: category?.rawValue)
        APIManager.shared.request(endpoint: endpoint) { (result: Result<NewsResponse, NetworkError>) in
            switch result {
            case .success(let newsResponse):
                completion(.success(newsResponse.articles))
            case .failure(let error):
                print("error :::::: ",error)
                completion(.failure(error))
            }
        }

### Fetching Articles by Category

   To enhance user experience, the CryptoFinder app allows you to fetch articles filtered by specific categories. You can specify a category when calling the `fetchNews` method in the `NewsService`. 

- Below is an example of how to request articles related to a specific category, such as Business::

   ```swift
   newsService.fetchNews(category: .business) { result in
       switch result {
       case .success(let articles):
           // Use the fetched articles
           print("Business articles: \(articles)")
       case .failure(let error):
           // Handle any errors that occur
           print("Error fetching business articles: \(error.localizedDescription)")
       }
   }
   

### Supported Categories

The CryptoFinder app provides users with the ability to filter articles based on various news categories. This feature helps users easily find news that aligns with their interests. Below are the supported categories:

- **All**: Displays all available articles from different sources, providing a comprehensive view of current events.
- **Business**: Articles related to business news, including market updates, financial news, and economic trends.
- **Entertainment**: Covers news from the entertainment industry, including movies, music, celebrity gossip, and events.
- **Health**: Articles focusing on health-related topics, including wellness tips, medical breakthroughs, and health news.
- **Science**: Features articles about scientific discoveries, research findings, and innovations across various fields.
- **Sports**: News related to sports events, athlete performances, and updates from the sports world.
- **Technology**: Articles about the latest trends in technology, gadget reviews, software updates, and tech industry news.

Users can select any of these categories to tailor their news feed according to their preferences, making it easier to stay informed about topics that matter to them.


## Usage

To use the CryptoFinder app, follow these steps:

1. **Launch the App**: 
   Open the CryptoFinder app on your device or simulator. You will be greeted with the home screen displaying the latest articles.

2. **View Articles**: 
   Tap on any article to read its full content. This will navigate you to a detailed view of the article where you can find additional information.

3. **Bookmark Articles**: 
   Use the bookmark feature to save articles for later reading. This allows you to easily revisit your favorite articles without having to search for them again.

4. **Filter News by Category**: 
   Use the grid-based menu to filter news articles by category. Select from various categories such as Business, Entertainment, Health, Science, Sports, Technology, or All to customize your news feed based on your interests.

## Contributing

Contributions to the CryptoFinder app are welcome and encouraged! To contribute to the project, please follow these steps:

1. **Fork the Repository**: 
   Click the "Fork" button at the top right of the repository page to create your own copy of the project.

2. **Clone Your Fork**: 
   Clone your forked repository to your local machine using the command:

   ```bash
   git clone https://github.com/your-username/News-Reader-Swift-UI.git

3. Create a New Branch: Navigate to the project directory and create a new branch for your feature or bug fix:

   ```bash
   git checkout -b feature/YourFeatureName

4. Make Your Changes: Implement your changes, ensuring that your code adheres to the project's coding standards. Be sure to write tests for any new features or functionality.

5. Commit Your Changes: Commit your changes with a clear and descriptive message:

   ```bash
   git commit -m "Add a new feature"

6. Push to Your Branch: Push your changes to your forked repository:

   ```bash
   git push origin feature/YourFeatureName

7. Open a Pull Request: Go to the original repository and open a pull request from your branch. Provide a detailed description of the changes you made and the reasons behind them.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 

## Acknowledgments

We would like to acknowledge the following resources and contributors that have made this project possible:

- **NewsAPI**: Thank you to [NewsAPI](https://newsapi.org/) for providing a comprehensive and reliable source of news articles.
- **SwiftUI**: Special thanks to [SwiftUI](https://developer.apple.com/xcode/swiftui/) for the assistance in creating beautiful interfaces for this project and for providing resources that helped in developing the code.

If you find this project useful, consider giving it a star on GitHub or contributing to its development!


## Contact

For inquiries or feedback, please reach out:

- **Email**: [jyotipatil2505@gmail.com](mailto:jyotipatil2505@gmail.com)
- **GitHub**: [jyotipatil2505](https://github.com/jyotipatil2505)

Feel free to get in touch for any questions or suggestions regarding the CryptoFinder app!

