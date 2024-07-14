extension Date {
    var isExpired: Bool {
        self.addingTimeInterval(60) < Date()
    }
}
