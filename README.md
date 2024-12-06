# CryptoFinder App

The **CryptoFinder App** is a UIKit-based Mobile application designed to create a Crypto Coin List application that displays a list of cryptocurrency coins, allowing users to filter and search through the list using various options.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Screenshots](#screenshots)
- [Installation](#installation)
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


## Usage

To use the CryptoFinder app, follow these steps:

1. **Launch the App**: 
   Open the CryptoFinder app on your device or simulator. You will be greeted with the home screen displaying the list of Crypto Coins.

2. **Filter Coins by Status/Type**: 
   Tap on the filter option to apply multiple filters at once and narrow down the list of coins.
   - Filter by Active Status: Filter coins to show only active or inactive coins.
   - Filter by Coin Type: Filter coins based on their type (e.g., "Token", "Coin").
   - Filter by New Crypto: Show only new cryptocurrencies.

3. **Search for a Coin**: 
   Tap on the search bar to search for a specific coin by:
   - Coin Name: Type the name of the coin (e.g., Bitcoin).
   - Coin Symbol: Type the symbol (e.g., BTC).


## Contributing

Contributions to the CryptoFinder app are welcome and encouraged! To contribute to the project, please follow these steps:

1. **Fork the Repository**: 
   Click the "Fork" button at the top right of the repository page to create your own copy of the project.

2. **Clone Your Fork**: 
   Clone your forked repository to your local machine using the command:

   ```bash
   git clone https://github.com/jyotipatil2505/CleanArchitecture-MVVM-CryptoCoinsApp.git

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

- **Clean Architecture**: Thank you to [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) for providing a comprehensive and reliable framework for building scalable and maintainable software.
- **UIKit**: Special thanks to [UIKit](https://developer.apple.com/documentation/uikit/) for building user interfaces on iOS. UIKit has been instrumental in creating beautiful and responsive user interfaces for this project.
- **Swift**: Thank you to [Swift](https://www.swift.org/documentation/), Apple’s powerful and intuitive programming language.. Swift has been the backbone of this project, providing both performance and safety for writing high-quality code.

If you find this project useful, consider giving it a star on GitHub or contributing to its development!


## Contact

For inquiries or feedback, please reach out:

- **Email**: [jyotipatil2505@gmail.com](mailto:jyotipatil2505@gmail.com)
- **GitHub**: [jyotipatil2505](https://github.com/jyotipatil2505)

Feel free to get in touch for any questions or suggestions regarding the CryptoFinder app!

