import UIKit

class LoaderView: UIView {
    
    private let logoImageView: UIImageView
    private let messageLabel: UILabel
    private static var currentLoader: LoaderView?  // Track the current loader
    
    //MARK: - Initialization Methods
    override init(frame: CGRect) {
        logoImageView = UIImageView(image: UIImage(named: "bitCoin")) // Replace with your app logo
        messageLabel = UILabel()
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        // Configure logo
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.heightAnchor.constraint(equalToConstant: LayoutConstants.iconHeight).isActive = true // Adjust size
        logoImageView.widthAnchor.constraint(equalToConstant: LayoutConstants.iconHeight).isActive = true
        
        // Configure message label
        messageLabel.text = Localization.localizedString(for: "loading",defaultValue: "Loading....")
        messageLabel.textColor = .white
        messageLabel.font = UIFont.systemFont(ofSize: LayoutConstants.defaultFontSize, weight: .medium)
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a vertical stack view for branding elements
        let stackView = UIStackView(arrangedSubviews: [logoImageView, messageLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Spacing.smallVerticalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        // Center the stack view
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
    //MARK: - Private Methods
    private func stopLoader() {
        self.removeFromSuperview()
    }
    
    private func showLoader(in view: UIView) {
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Class method to show the loader
    class func showLoader(in view: UIView) {
        if currentLoader == nil {
            let loader = LoaderView(frame: .zero)
            loader.showLoader(in: view)
            currentLoader = loader
        }
    }
    
    // Class method to hide the loader
    class func hideLoader() {
        currentLoader?.stopLoader()
        currentLoader = nil
    }
}
