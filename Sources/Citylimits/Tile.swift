protocol PowerProducer {
    var outputCapacity: Int { get }
}

protocol PowerConsumer {
    var powerDemand: Int { get }
}
