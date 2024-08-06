public enum DataOperationError: Error {
    case lastOfKind(type: String)
    case existingRelationship(type: String)
}
