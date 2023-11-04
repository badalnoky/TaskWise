public extension Int {
    static var one: Int = 1

    var previous: Int {
        self - 1
    }

    var next: Int {
        self + 1
    }
}
