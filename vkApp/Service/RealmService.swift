import RealmSwift

class RealmService {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func save<T:Object> (items: [T],
                                configuration: Realm.Configuration = deleteIfMigration,
                                update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(items, update: update)
        }
    }
    
    static func load<T:Object> (typeOf: T.Type) throws -> Results<T> {
        print(Realm.Configuration().fileURL ?? "")
        
        let realm = try Realm()
        let object = realm.objects(T.self)
        
        return object
    }
    
    static func delete<T:Object> (object: Results<T>) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(object)
        }
    }
}



public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

class WriteTransaction {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    private let realm: Realm
    internal init(realm: Realm) {
        self.realm = realm
    }
    func add<T: Persistable>(_ items: T, configuration: Realm.Configuration = deleteIfMigration, update: Realm.UpdatePolicy = .modified) {
        realm.add(items.managedObject(), update: update)
    }
}

// Implement the Container
class Container {
    private let realm: Realm
    public convenience init() throws {
        try self.init(realm: Realm())
    }
    internal init(realm: Realm) {
        self.realm = realm
    }
    func write(_ block: (WriteTransaction) throws -> Void)
    throws {
        let transaction = WriteTransaction(realm: realm)
        try realm.write {
            try block(transaction)
        }
    }
}
