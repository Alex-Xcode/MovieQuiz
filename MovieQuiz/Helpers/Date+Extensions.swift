import Foundation

private let dateTimeDefaultFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
<<<<<<< HEAD
    dateFormatter.dateFormat = "dd.MM.YY hh:mm"
=======
    dateFormatter.dateFormat = "dd.MM.YY HH:mm"
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
    return dateFormatter
}()

extension Date {
    var dateTimeString: String { dateTimeDefaultFormatter.string(from: self) }
}
