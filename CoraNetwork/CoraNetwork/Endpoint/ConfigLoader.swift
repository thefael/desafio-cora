public struct ConfigLoader {
    public static func getConfigProperty(_ key: ConfigKey) -> String {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let configuration = try? PropertyListSerialization.propertyList(
                from: data,
                format: nil
              ) as? [String: Any],
              let value = configuration[key.rawValue] as? String else {
            fatalError("\(key) not found in Info.plist.")
        }
        return value
    }
}
