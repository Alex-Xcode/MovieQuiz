import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
<<<<<<< HEAD
        indices ~= index ? self[index] : nil
=======
        indices.contains(index) ? self[index] : nil
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
    }
}
