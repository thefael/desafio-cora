public extension String {
    func applyMask(_ mask: DocumentMask) -> String {
        var formattedText = ""
        var index = self.startIndex
        
        for char in mask.rawValue where index < self.endIndex {
            if char == "#" {
                formattedText.append(self[index])
                index = self.index(after: index)
            } else {
                formattedText.append(char)
            }
        }
        return formattedText
    }
    
    enum DocumentMask: String {
        case cpf = "###.###.###-##"
        case cnpj = "##.###.###/####-##"
    }
}
