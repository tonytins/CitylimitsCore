// TODO: Add and conform this to Codable
/// This is intended as a human-readable form of the save-file.
///
/// ```json
/// {
///   "lastTax": 0,
///   "map": {
///   "height": 12,
///   "width": 12,
///   "tiles": [
///     [".",".",".",".",".",".",".",".",".",".",".","."],
///     [".",".",".",".",".",".",".",".",".",".",".","."],
///     [".","🏠","🏠","🏢","🚉","🏠",".",".",".",".",".","."],
///     ["⚡","=","=","=","=","=",".",".",".",".",".","."],
///     [".",".","🏭",".","🏭",".",".",".",".",".",".","."],
///     ],
///     }
/// }
/// ```
public struct JsonSave {
    public var treasury: Int
    public var population: Int
    public var lastTax: Int
    public var map: Map
    
    public init(treasury: Int, population: Int, lastTax: Int, map: Map) {
        self.treasury = treasury
        self.population = population
        self.lastTax = lastTax
        self.map = map
    }
    
}
