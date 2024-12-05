import UIKit

class FilterView: UIView {
    
    private let applyButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    private var buttons: [UIButton] = []
    
    var selectedFilters: Set<FilterOption> = []
    
    // Closure to handle the apply action
    var onApplyFilters: ((Set<FilterOption>) -> Void)?
    var onCancelFilters: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true

        // Create an array of button titles
        let buttonTitles = [
            "Active Coins", "Inactive Coins", "Only Coins",
            "Only Tokens", "New Coins"
        ]

        // Create the buttons dynamically and add them to the array
        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.systemBlue.cgColor
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button.addTarget(self, action: #selector(toggleFilterSelection(_:)), for: .touchUpInside)
            buttons.append(button)
        }

        // Style Apply and Cancel buttons
        applyButton.setTitle("Apply", for: .normal)
        applyButton.addTarget(self, action: #selector(applyFilters), for: .touchUpInside)
        applyButton.layer.cornerRadius = 23
        applyButton.backgroundColor = .systemBlue
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.heightAnchor.constraint(equalToConstant: 46).isActive = true

        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelFilter), for: .touchUpInside)
        cancelButton.layer.cornerRadius = 23
        cancelButton.backgroundColor = .systemGray
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.heightAnchor.constraint(equalToConstant: 46).isActive = true

        // Main vertical stack view
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 20
        mainStackView.alignment = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        // Add buttons to horizontal stack views (3 per row)
        var rowStackViews: [UIStackView] = []
        var rowButtons: [UIButton] = []

        for (index, button) in buttons.enumerated() {
            rowButtons.append(button)

            // If we have 3 buttons in a row, create a stack view for that row
            if rowButtons.count == 3 || index == buttons.count - 1 {
                let rowStackView = UIStackView(arrangedSubviews: rowButtons)
                rowStackView.axis = .horizontal
                rowStackView.spacing = 10
                rowStackView.alignment = .center
                rowStackView.distribution = .fillEqually
                rowStackView.translatesAutoresizingMaskIntoConstraints = false
                rowStackViews.append(rowStackView)
                rowButtons = [] // Reset row buttons
            }
        }

        // Add all row stack views to the main stack view
        for rowStackView in rowStackViews {
            mainStackView.addArrangedSubview(rowStackView)
        }

        // Create a horizontal stack view for Apply and Cancel buttons
        let actionButtonStackView = UIStackView(arrangedSubviews: [cancelButton, applyButton])
        actionButtonStackView.axis = .horizontal
        actionButtonStackView.spacing = 10
        actionButtonStackView.alignment = .fill
        actionButtonStackView.distribution = .fillEqually
        actionButtonStackView.translatesAutoresizingMaskIntoConstraints = false

        // Add the action button stack view to the main stack view
        mainStackView.addArrangedSubview(actionButtonStackView)

        // Add the main stack view to the view
        addSubview(mainStackView)

        // Set constraints for the main stack view
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func updateButtonStates() {
        for button in buttons {
            guard let title = button.title(for: .normal),
                  let option = FilterOption(rawValue: title) else { continue }
            
            if selectedFilters.contains(option) {
                button.backgroundColor = .systemBlue
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .white
                button.setTitleColor(.systemBlue, for: .normal)
            }
        }
    }

    
    @objc private func toggleFilterSelection(_ sender: UIButton) {
        guard let tagValue = sender.title(for: .normal), let option = FilterOption(rawValue: tagValue) else { return }
        sender.layer.borderColor = UIColor.systemBlue.cgColor // Change border color to green
        
        // Check if the filter is already selected
        if selectedFilters.contains(option) {
            // Deselect the filter
            selectedFilters.remove(option)
            // Reset button's background and border color
            sender.backgroundColor = .white // Reset background color to clear
            sender.setTitleColor(.systemBlue, for: .normal)
        } else {
            // Select the filter
            selectedFilters.insert(option)
            // Change button's border and background color for selection
            sender.backgroundColor = UIColor.systemBlue // Highlight with background color
            sender.setTitleColor(.white, for: .normal)
        }
    }
    
    @objc private func applyFilters() {
        onApplyFilters?(selectedFilters)
    }
    
    @objc private func cancelFilter() {
        onCancelFilters?()
    }
}
