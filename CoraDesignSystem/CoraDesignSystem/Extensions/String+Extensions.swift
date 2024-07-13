
public extension String {
    func applyCpfMask() -> String {
        let mask = "###.###.###-##"
        var formattedText = ""
        var index = self.startIndex
        
        for char in mask where index < self.endIndex {
            if char == "#" {
                formattedText.append(self[index])
                index = self.index(after: index)
            } else {
                formattedText.append(char)
            }
        }
        return formattedText
    }
}
