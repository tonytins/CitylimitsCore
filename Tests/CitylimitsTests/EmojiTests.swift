import Testing
@testable import Citylimits

// TODO: Find a way to parameterize this
@Suite("Emoji State")
struct EmojiTests {
    let midPopulation = 20
    let highPopulation = 30
    
    @Test("Residential emoji is derelict at zero population")
    func residentialEmojihLow() {
        let tile = Tile(type: .residential, population: 0)
        #expect(tile.emojiState == "🏚️")
    }
    
    @Test("Residential emoji is derelict at mid population")
    func residentialEmojihMid() {
        let tile = Tile(type: .residential, population: midPopulation)
        #expect(tile.emojiState == "🏠")
    }
    
    @Test("Residential emoji is derelict at high population")
    func residentialEmojihHigh() {
        let tile = Tile(type: .residential, population: highPopulation)
        #expect(tile.emojiState == "🏘️")
    }
    
    @Test("Commercial emoji is derelict at zero population")
    func commercialEmojihLow() {
        let tile = Tile(type: .commercial, population: 0)
        #expect(tile.emojiState == "🏪")
    }
    
    @Test("Commercial emoji is derelict at mid population")
    func commercialEmojihMid() {
        let tile = Tile(type: .commercial, population: midPopulation)
        #expect(tile.emojiState == "🏬")
    }
    
    @Test("Commercial emoji is derelict at high population")
    func commercialEmojihHigh() {
        let tile = Tile(type: .commercial, population: highPopulation)
        #expect(tile.emojiState == "🏢")
    }

}
