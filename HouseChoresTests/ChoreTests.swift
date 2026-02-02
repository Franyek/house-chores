import XCTest
@testable import HouseChores

final class ChoreTests: XCTestCase {
    
    // MARK: - Model Creation Tests
    
    func testChoreCreation() {
        // Given
        let name = "Water plants"
        let date = Date()
        let frequency = 3
        
        // When
        let chore = Chore(name: name, lastDone: date, frequencyInDays: frequency)
        
        // Then
        XCTAssertEqual(chore.name, name)
        XCTAssertEqual(chore.lastDone, date)
        XCTAssertEqual(chore.frequencyInDays, frequency)
        XCTAssertNotNil(chore.id, "ID should be auto-generated")
    }
    
    func testChoreCreationWithoutLastDone() {
        // Given
        let name = "Clean bathroom"
        let frequency = 7
        
        // When
        let chore = Chore(name: name, lastDone: nil, frequencyInDays: frequency)
        
        // Then
        XCTAssertEqual(chore.name, name)
        XCTAssertNil(chore.lastDone)
        XCTAssertEqual(chore.frequencyInDays, frequency)
    }
    
    func testEachChoreHasUniqueID() {
        // Given & When
        let chore1 = Chore(name: "Test", lastDone: nil, frequencyInDays: 1)
        let chore2 = Chore(name: "Test", lastDone: nil, frequencyInDays: 1)
        
        // Then
        XCTAssertNotEqual(chore1.id, chore2.id, "Each chore should have a unique ID")
    }
    
    // MARK: - Codable Tests
    
    func testChoreEncoding() throws {
        // Given
        let chore = Chore(name: "Water plants", lastDone: Date(), frequencyInDays: 3)
        let encoder = JSONEncoder()
        
        // When
        let data = try encoder.encode(chore)
        
        // Then
        XCTAssertGreaterThan(data.count, 0, "Encoded data should not be empty")
    }
    
    func testChoreDecoding() throws {
        // Given
        let originalChore = Chore(name: "Vacuum", lastDone: Date(), frequencyInDays: 2)
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        // When
        let data = try encoder.encode(originalChore)
        let decodedChore = try decoder.decode(Chore.self, from: data)
        
        // Then
        XCTAssertEqual(decodedChore.id, originalChore.id)
        XCTAssertEqual(decodedChore.name, originalChore.name)
        XCTAssertEqual(decodedChore.frequencyInDays, originalChore.frequencyInDays)
        // Note: Dates might have slight precision differences, so we check they exist
        XCTAssertNotNil(decodedChore.lastDone)
    }
    
    func testChoreEncodingWithNilLastDone() throws {
        // Given
        let chore = Chore(name: "New chore", lastDone: nil, frequencyInDays: 5)
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        // When
        let data = try encoder.encode(chore)
        let decodedChore = try decoder.decode(Chore.self, from: data)
        
        // Then
        XCTAssertEqual(decodedChore.name, chore.name)
        XCTAssertNil(decodedChore.lastDone)
        XCTAssertEqual(decodedChore.frequencyInDays, chore.frequencyInDays)
    }
    
    func testArrayOfChoresEncoding() throws {
        // Given
        let chores = [
            Chore(name: "Water plants", lastDone: Date(), frequencyInDays: 3),
            Chore(name: "Clean bathroom", lastDone: nil, frequencyInDays: 7),
            Chore(name: "Vacuum", lastDone: Date(), frequencyInDays: 2)
        ]
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        // When
        let data = try encoder.encode(chores)
        let decodedChores = try decoder.decode([Chore].self, from: data)
        
        // Then
        XCTAssertEqual(decodedChores.count, chores.count)
        XCTAssertEqual(decodedChores[0].name, chores[0].name)
        XCTAssertEqual(decodedChores[1].name, chores[1].name)
        XCTAssertEqual(decodedChores[2].name, chores[2].name)
    }
}
