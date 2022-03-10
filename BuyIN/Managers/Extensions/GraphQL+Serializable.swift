 
import Buy

extension GraphQL.AbstractResponse: Serializable {
    
    static func deserialize(from representation: SerializedRepresentation) -> Self? {
        return try? self.init(fields: representation)
    }
    
    func serialize() -> SerializedRepresentation {
        return self.fields
    }
}
