extension StringProtocol {
    var isValidCpf: Bool {
        let numbers = compactMap(\.wholeNumberValue)
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        return numbers.prefix(9).cpfDigit == numbers[9] &&
        numbers.prefix(10).cpfDigit == numbers[10]
    }
    
    var isValidPassword: Bool {
        self.count >= 6
    }
}

extension Collection where Element == Int {
    var cpfDigit: Int {
        var number = count + 2
        let digit = 11 - reduce(into: 0) {
            number -= 1
            $0 += $1 * number
        } % 11
        return digit > 9 ? 0 : digit
    }
}
