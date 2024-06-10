
internal extension Array {
    func splitBy(_ chunkSize: Int) -> [ArraySlice<Element>] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            self[$0..<Swift.min($0 + chunkSize, self.count)]
        }
    }
}
