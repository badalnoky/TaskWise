import CloudKit

protocol CloudItem {
    var record: CKRecord { get }

    init?(from record: CKRecord)
}
