public extension Int {
    static var one: Int = 1
    static var ten: Int = 10
    static var descriptionLineLimit: Int = 3

    var previous: Int {
        self - 1
    }

    var next: Int {
        self + 1
    }
}
