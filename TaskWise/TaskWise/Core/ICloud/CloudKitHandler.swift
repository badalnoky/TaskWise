import CloudKit
import Combine

enum CloudKitHandler {
    static func getCloudStatus() -> Future<Bool, Error> {
        Future { promise in
            CKContainer.default().accountStatus { status, error in
                switch status {
                case .couldNotDetermine: promise(.failure(CloudKitError.accountNotDetermined))
                case .available: promise(.success(true))
                case .restricted: promise(.failure(CloudKitError.accountRestricted))
                case .noAccount: promise(.failure(CloudKitError.accountNotFound))
                case .temporarilyUnavailable: promise(.failure(CloudKitError.accountTemporarilyUnavailable))
                @unknown default: promise(.failure(CloudKitError.accountUnkown))
                }
            }
        }
    }

    static func getUserId() -> Future<CKRecord.ID, Error> {
        Future { promise in
            CKContainer.default().fetchUserRecordID { id, error in
                if error != nil {
                    promise(.failure(CloudKitError.userIdCouldNotBeRetrieved))
                } else if let id = id {
                    promise(.success(id))
                }
            }
        }
    }
}

// MARK: CRUD
extension CloudKitHandler {
    static func fetch<T: CloudItem>(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptors: [NSSortDescriptor]? = nil,
        resultsLimit: Int? = nil
    ) -> Future<[T], Error> {
        Future { promise in
            let query = CKQuery(recordType: recordType, predicate: predicate)
            query.sortDescriptors = sortDescriptors
            let queryOperation = CKQueryOperation(query: query)
            if let limit = resultsLimit { queryOperation.resultsLimit = limit}
            var items: [T] = []

            queryOperation.recordMatchedBlock = { recordId, result in
                switch result {
                case .success(let record):
                    guard let item = T(from: record) else { return }
                    items.append(item)
                case .failure(_): break
                }
            }

            queryOperation.queryResultBlock = { result in
                promise(.success(items))
            }

            CKContainer.default().privateCloudDatabase.add(queryOperation)
        }
    }

    private static func save<T: CloudItem>(item: T) -> Future<Bool, Error> {
        Future { promise in
            CKContainer.default().privateCloudDatabase.save(item.record) { record, error in
                if error != nil {
                    promise(.failure(CloudKitError.saveCouldNotBeCompleted))
                } else {
                    promise(.success(true))
                }
            }
        }
    }

    static func add<T: CloudItem>(item: T) -> Future<Bool, Error> {
        save(item: item)
    }

    static func update<T: CloudItem>(item: T) -> Future<Bool, Error> {
        save(item: item)
    }

    static func delete<T: CloudItem>(item: T) -> Future<Bool, Error> {
        Future { promise in
            CKContainer.default().privateCloudDatabase.delete(withRecordID: item.record.recordID) { record, error in
                if error != nil {
                    promise(.failure(CloudKitError.deletionCouldNotBeCompleted))
                } else {
                    promise(.success(true))
                }
            }
        }
    }
}
