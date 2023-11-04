import Foundation

enum CloudKitError: String, LocalizedError {
    case accountNotDetermined
    case accountRestricted
    case accountNotFound
    case accountUnkown
    case accountTemporarilyUnavailable
    case userIdCouldNotBeRetrieved
    case saveCouldNotBeCompleted
    case deletionCouldNotBeCompleted
}
