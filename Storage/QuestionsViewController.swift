//
//  QuestionsViewController.swift
//  QuizApp
//

import UIKit

class QuestionsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: - Properties
    var topic: Topic?
    private var questions: [Question] = []
    private let dataManager = QuizDataManager.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadQuestions()
    }
    
    private func setupUI() {
        title = topic?.title ?? "Questions"
        
        if let topic = topic {
            topicTitleLabel.text = "\(topic.title)\n\(topic.questionCount) questions"
        }
        
        startButton.layer.cornerRadius = 12
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(toggleEdit)
        )
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "QuestionCell")
    }
    
    private func loadQuestions() {
        guard let topic = topic else { return }
        questions = dataManager.loadQuestions(forTopicId: topic.id)
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func startQuizTapped(_ sender: UIButton) {
        if questions.isEmpty {
            let alert = UIAlertController(
                title: "No Questions",
                message: "This topic has no questions",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "QuestionDetailViewController") as? QuestionDetailViewController {
            detailVC.questions = questions
            detailVC.currentIndex = 0
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    @objc private func toggleEdit() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.rightBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    }
    
    private func toggleBookmark(at index: Int) {
        questions[index].isBookmarked.toggle()
        
        // Update local storage
        var allQuestions = dataManager.loadQuestions()
        if let i = allQuestions.firstIndex(where: { $0.id == questions[index].id }) {
            allQuestions[i].isBookmarked = questions[index].isBookmarked
            _ = dataManager.saveQuestions(allQuestions)
        }
        
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

// MARK: - TableView Methods
extension QuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        let question = questions[indexPath.row]
        
        cell.textLabel?.text = question.questionText
        cell.textLabel?.numberOfLines = 2
        cell.detailTextLabel?.text = "Difficulty: \(question.difficulty)"
        
        // Bookmark indicator
        let bookmarkImage = question.isBookmarked ? "★" : "☆"
        cell.accessoryView = {
            let label = UILabel()
            label.text = bookmarkImage
            label.textColor = question.isBookmarked ? .orange : .gray
            label.font = .systemFont(ofSize: 20)
            label.sizeToFit()
            return label
        }()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "QuestionDetailViewController") as? QuestionDetailViewController {
            detailVC.questions = questions
            detailVC.currentIndex = indexPath.row
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    // Swipe actions
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let question = questions[indexPath.row]
        
        // Bookmark action
        let bookmarkAction = UIContextualAction(style: .normal, title: question.isBookmarked ? "Remove" : "Bookmark") { [weak self] (_, _, completion) in
            self?.toggleBookmark(at: indexPath.row)
            completion(true)
        }
        bookmarkAction.backgroundColor = .orange
        bookmarkAction.image = UIImage(systemName: question.isBookmarked ? "bookmark.slash" : "bookmark")
        
        return UISwipeActionsConfiguration(actions: [bookmarkAction])
    }
}
