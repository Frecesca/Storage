//
//  TopicsViewController.swift
//  QuizApp
//

import UIKit
import Network

class TopicsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var offlineLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private var topics: [Topic] = []
    private let dataManager = QuizDataManager.shared
    private let monitor = NWPathMonitor()
    private var isOffline = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        checkNetwork()
        loadData()
    }
    
    private func setupUI() {
        title = "Quiz Topics"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Settings button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .plain,
            target: self,
            action: #selector(openSettings)
        )
        
        // Refresh button style
        refreshButton.layer.cornerRadius = 12
        
        // Offline label (hidden by default)
        offlineLabel.isHidden = true
        offlineLabel.layer.cornerRadius = 8
        offlineLabel.clipsToBounds = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TopicCell")
    }
    
    private func checkNetwork() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isOffline = path.status != .satisfied
                self?.offlineLabel.isHidden = !(self?.isOffline ?? false)
                self?.refreshButton.isEnabled = !(self?.isOffline ?? false)
                self?.refreshButton.alpha = (self?.isOffline ?? false) ? 0.5 : 1.0
            }
        }
        monitor.start(queue: DispatchQueue(label: "network"))
    }
    
    private func loadData() {
        if dataManager.hasLocalData() {
            topics = dataManager.loadTopics()
        } else {
            dataManager.createMockData()
            topics = dataManager.loadTopics()
        }
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func refreshTapped(_ sender: UIButton) {
        if isOffline {
            let alert = UIAlertController(
                title: "Offline",
                message: "Cannot sync while offline",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        // Show loading
        activityIndicator.startAnimating()
        refreshButton.isEnabled = false
        
        // Simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.refreshButton.isEnabled = true
            
            // In real app, you would fetch from server here
            let alert = UIAlertController(
                title: "Success",
                message: "Data synced!",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    @objc private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - TableView Methods
extension TopicsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.isEmpty ? 1 : topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if topics.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath)
            cell.textLabel?.text = "No topics available"
            cell.textLabel?.textColor = .gray
            cell.textLabel?.textAlignment = .center
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath)
        let topic = topics[indexPath.row]
        
        cell.textLabel?.text = topic.title
        cell.detailTextLabel?.text = "\(topic.description) - \(topic.questionCount) questions"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard !topics.isEmpty else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let questionsVC = storyboard.instantiateViewController(withIdentifier: "QuestionsViewController") as? QuestionsViewController {
            questionsVC.topic = topics[indexPath.row]
            navigationController?.pushViewController(questionsVC, animated: true)
        }
    }
}
