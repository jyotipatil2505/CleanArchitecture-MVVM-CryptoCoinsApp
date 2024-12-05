import UIKit

class CryptoListViewController: UIViewController {
    var viewModel: CryptoListViewModel!
    let tableView = UITableView()
    private var selectedFilterOptions: Set<FilterOption> = []
    private var filterView: FilterView?
    private var noDataContainer: UIView? // Global container for the no-data view
    private var blurEffectView: UIVisualEffectView? // Blur effect view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
        setupUI()
        setupBindings()
        viewModel.fetchCoins()
        setupNavigationBar() // Add this
    }
    
    private func initializeViewModel() {
        // Initialize Data Layer (Network and Local Data Sources)
        let apiService = APIService() // Assuming it's already implemented
        let networkDataSource = CryptoNetworkDataSourceImpl(apiService: apiService)
        let localDataSource = CryptoLocalDataSourceImpl()
        let repository = CryptoRepository(networkDataSource: networkDataSource, localDataSource: localDataSource)
        let useCase = GetCryptoCoinsUseCase(repository: repository)
        
        // Initialize ViewModel
        viewModel = CryptoListViewModel(getCryptoCoinsUseCase: useCase)
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: "CryptoTableViewCell")
        
        setupConstraints()
    }
    
    private func setupBlurEffect() {
        if blurEffectView == nil {
            // Create a blur effect view
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.alpha = 0 // Initially invisible
            
            // Add the blur effect view below all subviews
            view.insertSubview(blurEffectView, belowSubview: self.view)
            self.blurEffectView = blurEffectView
        }
    }
    
    private func showBlurEffect() {
        setupBlurEffect() // Ensure the blur effect view exists
        UIView.animate(withDuration: 0.2) {
            self.blurEffectView?.alpha = 1 // Fade in
        }
    }
    
    private func hideBlurEffect() {
        guard let blurEffectView = blurEffectView else { return }
        UIView.animate(withDuration: 0.2, animations: {
            blurEffectView.alpha = 0 // Fade out
        }) { _ in
            blurEffectView.removeFromSuperview()
            self.blurEffectView = nil // Clean up
        }
    }
    
    
    private func setupNavigationBar() {
        title = "Crypto Coins"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemBlue
        
        // Add a UISearchController
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Crypto Coins"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.tintColor = .systemBlue
        
        
        // Attach the search controller to the navigation bar
        navigationItem.searchController = searchController
        
        // Create the filter button (right bar button)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.horizontal.3.decrease.circle"),
            style: .plain,
            target: self,
            action: #selector(showFilterOptions)
        )
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc private func hideFilterOptions() {
        UIView.animate(withDuration: 0.3, animations: {
            self.filterView?.frame.origin.y = self.view.frame.height
        }) { _ in
            self.filterView?.removeFromSuperview()
            self.filterView = nil
            self.hideBlurEffect() // Hide blur after removing filter view
        }
    }
    
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.updateNoDataView()
            }
        }
        
        viewModel.showLoader = {
            DispatchQueue.main.async {
                LoaderView.showLoader(in: self.view)  // Show loader when data is fetching
            }
        }
        
        viewModel.hideLoader = {
            DispatchQueue.main.async {
                LoaderView.hideLoader()  // Hide loader when data fetch is complete
            }
        }
        
        viewModel.handleError = { title, message in
            self.showAlert(message: message, title: title)
        }
    }
    
    @objc private func showFilterOptions() {
        guard filterView == nil else { return }
        
        showBlurEffect() // Show blur before adding filter view
        
        let numberOfRows = 2
        let buttonHeight: CGFloat = 30
        let spacing: CGFloat = 20
        let applyButtonHeight: CGFloat = 46
        let filterViewHeight = CGFloat(numberOfRows) * buttonHeight + spacing + applyButtonHeight + 110
        
        let filterFrame = CGRect(
            x: 0,
            y: view.frame.height,
            width: view.frame.width,
            height: filterViewHeight
        )
        
        filterView = FilterView(frame: filterFrame)
        filterView?.onApplyFilters = { [weak self] selectedOptions in
            self?.applySelectedFilters(selectedOptions)
            self?.hideFilterOptions()
        }
        
        filterView?.onCancelFilters = { [weak self] in
            self?.hideFilterOptions()
        }
        
        filterView?.selectedFilters = selectedFilterOptions
        filterView?.updateButtonStates()
        
        view.addSubview(filterView!) // Add filter view on top of the blur effect
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.filterView?.frame.origin.y = self.view.frame.height - (self.filterView?.frame.height ?? 0)
        }
    }
    
    
    
    private func applySelectedFilters(_ selectedOptions: Set<FilterOption>) {
        // Update the local filter state
        selectedFilterOptions = selectedOptions
        
        // Apply filters in the view model
        let isActive = selectedOptions.contains(.activeCoins) ? selectedOptions.contains(.activeCoins) : nil
        let isInactive = selectedOptions.contains(.inactiveCoins) ? selectedOptions.contains(.inactiveCoins) : nil
        let isNew = selectedOptions.contains(.newCoins) ? selectedOptions.contains(.newCoins) : nil
        let onlyCoins = selectedOptions.contains(.onlyCoins) ? "coin" : nil
        let onlyTokens = selectedOptions.contains(.onlyTokens) ? "token" : nil
        viewModel.filterCoins(isActive: isActive, isInactive: isInactive, onlyCoins: onlyCoins, isNew: isNew, onlyTokens: onlyTokens)
    }
    
    
    // Method to handle no data view
    private func updateNoDataView() {
        // If no coins available, show the no data label
        if viewModel.isFilteredCoinsEmpty {
            showNoDataView()
        } else {
            hideNoDataView()
        }
    }
    
    private func showNoDataView() {
        if noDataContainer == nil {
            // Create the label
            let label = UILabel()
            label.text = "No data available"
            label.textColor = .gray
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            // Create the icon
            let icon = UIImageView(image: UIImage(systemName: "exclamationmark.triangle"))
            icon.tintColor = .gray
            icon.translatesAutoresizingMaskIntoConstraints = false
            
            // Create a container view to hold the icon and label
            let containerView = UIStackView(arrangedSubviews: [icon, label])
            containerView.axis = .vertical
            containerView.spacing = 8
            containerView.alignment = .center
            containerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.alpha = 0 // Start with invisible
            
            view.addSubview(containerView)
            noDataContainer = containerView
            
            // Set constraints for the container view
            NSLayoutConstraint.activate([
                containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
            
            // Animate the appearance
            UIView.animate(withDuration: 0.2) {
                containerView.alpha = 1.0
            }
        }
    }
    
    
    private func hideNoDataView() {
        guard let noDataContainer = noDataContainer else { return }
        
        // Animate the disappearance
        UIView.animate(withDuration: 0.2, animations: {
            noDataContainer.alpha = 0 // Fade out
        }) { _ in
            // Remove the container and clean up after the animation completes
            noDataContainer.removeFromSuperview()
            self.noDataContainer = nil
        }
    }
    
}
