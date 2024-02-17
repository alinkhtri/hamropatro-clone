//
//  HomeViewController.swift
//  hamro-patro
//
//  Created by Alin Khatri on 13/01/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Variables
    let options = [("Hamro Pay", "iphone"), ("Jyotish", "video.bubble"), ("Doctor", "plus.square"), ("News", "newspaper"), ("Radio", "radio"), ("Bank Rates", "indianrupeesign.arrow.circlepath"),
                   ("Recipe", "fork.knife"), ("Video", "play.circle"), ("Audio", "music.note"), ("Rashifal", "moon"), ("Kundali", "command.square"), ("Sahakari Deposit", "building.columns"),
                   ("TV", "tv"), ("Education Fee", "graduationcap"), ("Insurance", "umbrella"), ("Financial Services", "dollarsign.circle"), ("Health", "plus.circle"), ("Bus Ticket", "bus"),
                   ("Movies", "play.rectangle"), ("Voting & Events", "menucard"), ("Online Payment", "cart"), ("Antivirus", "shield"), ("Community Electricity", "bolt.batteryblock")]
    
    // MARK: - UI Components
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.isDirectionalLockEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.crop.circle")
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.white
        image.backgroundColor = UIColor.accent
        image.frame =  CGRect(x: 10, y: 3, width: 28, height: 28)
        return image
    }()
    
    // MARK: - Lifecycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.setupStatusBar()
        self.setupNavigationBar()
        self.setupScrollView()
        
    }
    
    private func setupStatusBar() {
        // Set the status bar background color
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = .accent
        view.addSubview(statusBarView)
    }
    
    func setupUserBarButton() {
        // Create a custom view button for the right user bar button item
        let customButton = UIButton(type: .custom)
        customButton.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        
        // Add the image view and label to the custom button
        customButton.addSubview(userImageView)
        
        // Add the custom button as the left bar button item
        let leftBarButton = UIBarButtonItem(customView: customButton)
        navigationItem.leftBarButtonItem = leftBarButton
        
    }
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.backgroundColor = .accent
        navigationController?.navigationBar.tintColor = UIColor.white
        
        self.title = "हाम्रो पात्रो"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        // Add right bar button items
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: nil)
        
        let rightBarButton1 = UIBarButtonItem(image: UIImage(systemName: "envelope"), style: .plain, target: self, action: #selector(barButtonTapped))
        
        // Create a custom view button for the right user bar button item
        let customButton = UIButton(type: .custom)
        
        // Add the image view custom button
        customButton.addSubview(userImageView)
        customButton.addTarget(self, action: #selector(barButtonTapped), for: .touchUpInside)
        let rightBarButton2 = UIBarButtonItem(customView: customButton)
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItems = [rightBarButton1, rightBarButton2]
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.2)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(20)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
        ])
        
        // Add your subviews to the content view by calling the respective functions
        self.setupOptionsGrid(in: contentView)
        
    }
    
    private func setupOptionsGrid(in contentView: UIView) {
        let cardView = UIView(frame: CGRect(x: 20, y: 0 , width: view.bounds.width - 40, height: 530))
        
        
        // Add the card view as a subview to the main view
        contentView.addSubview(cardView)
        
        
        // Create a collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: cardView.bounds.width / 4, height: cardView.bounds.height / 6)
        
        // Initialize the collection view
        let collectionView = UICollectionView(frame: cardView.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ButtonCell")
        
        // Add the collection view to the card view
        cardView.addSubview(collectionView)
        
        // Set up constraints for the collection view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cardView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor)
        ])
        
        // Embed the card view into the scroll view
        scrollView.addSubview(cardView)
        
    }
        
    // MARK: - Selectors
    @objc func barButtonTapped() {
        let signupVC = SignUpViewController()
        let navController = UINavigationController(rootViewController: signupVC)
        navController.modalPresentationStyle = .pageSheet
        
        present(navController, animated: true, completion: nil)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath) as? UICollectionViewCell else {
            fatalError("Failed to dequeue cell")
        }
        
        let option = options[indexPath.item]
        
        // Remove any existing subviews from the cell
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let button = OptionButton(title: option.0, imageName: option.1, titleWeight: 0.2)
        button.frame = cell.contentView.bounds
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Assign the closure for button tap action
        button.onButtonTap = { option in
            // Handle the button tap action here
            print("Pressed option: \(option)")
        }
        
        cell.contentView.addSubview(button)
        
        return cell
    }
}
