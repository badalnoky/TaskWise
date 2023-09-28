import CloudKit

// TODO: Build this to an actual object
struct Task: CloudItem {
    var title: String
    var record: CKRecord

    init(title: String) {
        self.title = title
        let record = CKRecord(recordType: "Tasks")
        record["title"] = title
        self.record = record
    }

    init?(from record: CKRecord) {
        guard let title = record["title"] as? String else { return nil }
        self.title = title
        self.record = record
    }

    mutating func update(title: String) {
        self.title = title
        self.record["title"] = title
    }
}
