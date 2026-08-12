protocol PowerProducer {
    var outputCapacity: Int { get }
}

protocol PowerConsumer {
    var powerDemand: Int { get }
}

enum ActivityRequirement {
    case powerOnly
    case powerAndAdjacent(to: TileType)
    case powerAndAdjacentPopulated(TileType)
}

enum TaxModel {
    case perResident(numerator: Int, denumerator: Int)
    case flat(Int)
    case none
}
