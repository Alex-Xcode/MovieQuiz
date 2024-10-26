import UIKit

<<<<<<< HEAD
<<<<<<< HEAD

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
// MARK: - Properties
    private let questionsAmount: Int = 10
        private var questionFactory: QuestionFactoryProtocol?
        private var currentQuestion: QuizQuestion?
        private var currentQuestionIndex = 0
        private var correctAnswers = 0
        private var alertPresenter: AlertPresenter?
        private var statisticService: StatisticServiceProtocol?
        
// MARK: - Actions
=======
final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
    // MARK: - Properties
    private let questionsAmount: Int = 10
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: QuizQuestion?
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    private var alertPresenter: AlertPresenter?
    private var statisticService: StatisticServiceProtocol?
=======
final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol {
    // MARK: - Properties
    private var presenter: MovieQuizPresenter!
    private var alertPresenter: AlertPresenter?
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
    
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var noButton: UIButton!
    @IBOutlet private var yesButton: UIButton!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var counterLabel: UILabel!
    
<<<<<<< HEAD
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        statisticService = StatisticService()
        alertPresenter = AlertPresenter(controller: self)
        
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
        
        showLoadingIndicator()
        questionFactory?.loadData()
    }
    
    // MARK: - QuestionFactoryDelegate
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else { return }
        currentQuestion = question
        let viewModel = convert(model: question)
        
        DispatchQueue.main.async { [weak self] in
            self?.show(quizStep: viewModel)
        }
    }
    
    func didLoadDataFromServer() {
        hideLoadingIndicator()
        questionFactory?.requestNextQuestion()
    }

    func didFailToLoadData(with error: Error) {
        hideLoadingIndicator()
        showNetworkError(message: error.localizedDescription)
    }
    
    // MARK: - Private Methods
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let image = UIImage(data: model.image) ?? UIImage()
        return QuizStepViewModel(
            image: image,
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)"
        )
    }
    
    private func show(quizStep: QuizStepViewModel) {
        imageView.image = quizStep.image
        textLabel.text = quizStep.question
        counterLabel.text = quizStep.questionNumber
    }
    
    private func showNetworkError(message: String) {
        let alertModel = AlertModel(
            title: "Ошибка",
            message: message,
            buttonText: "Попробовать ещё раз"
        ) { [weak self] in
            self?.currentQuestionIndex = 0
            self?.correctAnswers = 0
            self?.showLoadingIndicator()
            self?.questionFactory?.loadData()
        }
        
        alertPresenter?.showAlert(with: alertModel)
    }
    
    private func showLoadingIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    private func hideLoadingIndicator() {
=======
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertPresenter = AlertPresenter(controller: self)
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        
        presenter = MovieQuizPresenter(viewController: self)
    }
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked()
    }
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        presenter.yesButtonClicked()
    }
    
    func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
    }
    
    func hideImageBorder() {
        imageView.layer.borderWidth = 0
    }
    
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        view.bringSubviewToFront(activityIndicator)
    }
    
    func hideLoadingIndicator() {
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
<<<<<<< HEAD
    // MARK: - Actions
>>>>>>> 6996d3308e530aff7762777e39587a03be7175bd
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else { return }
        let isCorrect = !currentQuestion.correctAnswer
        showAnswerResult(isCorrect: isCorrect)
    }
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else { return }
        let isCorrect = currentQuestion.correctAnswer
        showAnswerResult(isCorrect: isCorrect)
    }
    
<<<<<<< HEAD
    @IBOutlet private var noButton: UIButton!
    @IBOutlet private var yesButton: UIButton!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var counterLabel: UILabel!
    
// MARK: - Lifecycle
    override func viewDidLoad() {
            super.viewDidLoad()

            statisticService = StatisticService()
            
            // Инициализация фабрики вопросов и презентера алертов
            let questionFactory = QuestionFactory()
            questionFactory.setup(delegate: self)
            self.questionFactory = questionFactory

            alertPresenter = AlertPresenter(controller: self)

            // Настройка интерфейса
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 20
            imageView.layer.borderWidth = 8
            imageView.layer.borderColor = UIColor.clear.cgColor

            showNextQuestion()  // Показ первого вопроса при загрузке
        }

// MARK: - QuestionFactoryDelegate
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else { return }
        currentQuestion = question
        let viewModel = convert(model: question)
        
        DispatchQueue.main.async { [weak self] in
            self?.show(quizStep: viewModel)
        }
    }

    
// MARK: - Private Methods
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let image = UIImage(named: model.image) ?? UIImage(named: "Картинка заглушка") ?? UIImage()
        return QuizStepViewModel(
            image: image,
            question: model.text,
            questionNumber: formatQuestionNumber()
        )
    }
        
    private func formatQuestionNumber() -> String {
        return "\(currentQuestionIndex + 1)/\(questionsAmount)"
    }
        
    private func show(quizStep: QuizStepViewModel) {
        imageView.image = quizStep.image
        textLabel.text = quizStep.question
        counterLabel.text = quizStep.questionNumber
    }
        
    private func showFinalResults() {
        // Сохраняем текущие результаты
        statisticService?.store(correct: correctAnswers, total: questionsAmount)

        // Получаем данные из StatisticService
        guard let statisticService = statisticService else { return }
        
        let currentResult = "\(correctAnswers)/\(questionsAmount)"
        let totalGamesPlayed = statisticService.gamesCount
        let bestGame = statisticService.bestGame
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let formattedBestGameDate = dateFormatter.string(from: bestGame.date)
        let averageAccuracy = statisticService.totalAccuracy

        // Формируем текст для алерта
        let alertMessage = """
            Ваш результат: \(currentResult)
            Количество квизов: \(totalGamesPlayed)
            Лучший результат: \(bestGame.correct)/\(bestGame.total) (\(formattedBestGameDate))
            Средняя точность: \(String(format: "%.2f", averageAccuracy))%
        """
        let alertModel = AlertModel(
            title: "Финал",
            message: alertMessage,
            buttonText: "Попробовать снова",
            completion: { [weak self] in
                guard let self = self else { return }
                self.currentQuestionIndex = 0
                self.correctAnswers = 0
                self.showNextQuestion()
            }
        )
        
        alertPresenter?.showAlert(with: alertModel)
    }

        
=======
>>>>>>> 6996d3308e530aff7762777e39587a03be7175bd
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
        }
<<<<<<< HEAD
            
        let ypGreen = UIColor(red: 0x60/255.0, green: 0xC2/255.0, blue: 0x8E/255.0, alpha: 1.0)
        let ypRed = UIColor(red: 0xF5/255.0, green: 0x6B/255.0, blue: 0x6C/255.0, alpha: 1.0)
            
        imageView.layer.borderColor = isCorrect ? ypGreen.cgColor : ypRed.cgColor
        changeStateButton(isEnable: false)
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.imageView.layer.borderColor = UIColor.clear.cgColor
            self.changeStateButton(isEnable: true)
            self.showNextQuestionOrResults()
        }
    }
        
    private func showNextQuestionOrResults() {
        if currentQuestionIndex >= questionsAmount - 1 {
            showFinalResults()
        } else {
            currentQuestionIndex += 1
            showNextQuestion()
        }
    }
        
    private func showNextQuestion() {
        imageView.layer.borderColor = UIColor.clear.cgColor
        questionFactory?.requestNextQuestion()
    }
        
    private func changeStateButton(isEnable: Bool) {
        noButton.isEnabled = isEnable
        yesButton.isEnabled = isEnable
    }
}


=======

        imageView.layer.borderWidth = 8
        let ypGreen = UIColor(red: 0x60/255.0, green: 0xC2/255.0, blue: 0x8E/255.0, alpha: 1.0)
        let ypRed = UIColor(red: 0xF5/255.0, green: 0x6B/255.0, blue: 0x6C/255.0, alpha: 1.0)
        imageView.layer.borderColor = isCorrect ? ypGreen.cgColor : ypRed.cgColor
        
        noButton.isEnabled = false
        yesButton.isEnabled = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showNextQuestionOrResults()
            self.imageView.layer.borderWidth = 0
            self.noButton.isEnabled = true
            self.yesButton.isEnabled = true
        }
    }

    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 {
            statisticService?.store(correct: correctAnswers, total: questionsAmount)

            let text = """
                Ваш результат: \(correctAnswers)/\(questionsAmount)
                Количество сыгранных квизов: \(statisticService?.gamesCount ?? 0)
                Рекорд: \(statisticService?.bestGame.correct ?? 0)/\(statisticService?.bestGame.total ?? 0) (\(statisticService?.bestGame.date.dateTimeString ?? ""))
                Средняя точность: \(String(format: "%.2f", statisticService?.totalAccuracy ?? 0))%
                """

            let alertModel = AlertModel(
                title: "Этот раунд окончен!",
                message: text,
                buttonText: "Сыграть ещё раз"
            ) { [weak self] in
                guard let self = self else { return }
                self.currentQuestionIndex = 0
                self.correctAnswers = 0
                self.questionFactory?.requestNextQuestion()
            }

            alertPresenter?.showAlert(with: alertModel)
        } else {
            currentQuestionIndex += 1
            questionFactory?.requestNextQuestion()
        }
=======
    func showNetworkError(message: String) {
        let alertModel = AlertModel(
            title: "Ошибка сети",
            message: message,
            buttonText: "Попробовать ещё раз",
            completion: nil
        )
        showAlert(model: alertModel)
    }
    
    func showAlert(model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )
        alert.view.accessibilityIdentifier = "Alert"
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion?()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func setButtonsEnabled(_ isEnabled: Bool) {
        yesButton.isEnabled = isEnabled
        noButton.isEnabled = isEnabled
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
    }
}



<<<<<<< HEAD
>>>>>>> 6996d3308e530aff7762777e39587a03be7175bd
=======
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
<<<<<<< HEAD


=======
 
 
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
<<<<<<< HEAD


=======
 
 
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
<<<<<<< HEAD


=======
 
 
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
<<<<<<< HEAD


=======
 
 
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
<<<<<<< HEAD


=======
 
 
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
<<<<<<< HEAD


=======
 
 
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
<<<<<<< HEAD


=======
 
 
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
<<<<<<< HEAD


=======
 
 
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
<<<<<<< HEAD


=======
 
 
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 */
