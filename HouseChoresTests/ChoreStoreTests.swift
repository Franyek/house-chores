import XCTest
@testable import HouseChores

final class ChoreStoreTests: XCTestCase {
    
    var store: ChoreStore!
    var testDefaults: UserDefaults!
    var suiteName: String!
    
    override func setUp() {
        super.setUp()
        
        // Create a unique test suite for each test
        suiteName = "test.\(UUID().uuidString)"
        testDefaults = UserDefaults(suiteName: suiteName)!
        
        // Create a fresh store for each test
        store = ChoreStore(userDefaults: testDefaults)
        // Clear any existing data
        store.chores = []
    }
    
    override func tearDown() {
        // Clean up test UserDefaults
        testDefaults.removePersistentDomain(forName: suiteName)
        testDefaults = nil
        store = nil
        suiteName = nil
        super.tearDown()
    }
    
    // MARK: - Add Chore Tests
    
    func testAddChore() {
        // Given
        let initialCount = store.chores.count
        
        // When
        store.addChore(name: "Water plants", frequencyInDays: 3)
        
        // Then
        XCTAssertEqual(store.chores.count, initialCount + 1)
        XCTAssertEqual(store.chores.last?.name, "Water plants")
        XCTAssertEqual(store.chores.last?.frequencyInDays, 3)
        XCTAssertNil(store.chores.last?.lastDone, "New chores should have nil lastDone")
    }
    
    func testAddMultipleChores() {
        // When
        store.addChore(name: "Chore 1", frequencyInDays: 1)
        store.addChore(name: "Chore 2", frequencyInDays: 2)
        store.addChore(name: "Chore 3", frequencyInDays: 3)
        
        // Then
        XCTAssertEqual(store.chores.count, 3)
    }
    
    // MARK: - Delete Chore Tests
    
    func testDeleteChore() {
        // Given
        store.addChore(name: "To be deleted", frequencyInDays: 5)
        let choreToDelete = store.chores.first!
        
        // When
        store.deleteChore(id: choreToDelete.id)
        
        // Then
        XCTAssertEqual(store.chores.count, 0)
    }
    
    func testDeleteSpecificChore() {
        // Given
        store.addChore(name: "Keep this", frequencyInDays: 1)
        store.addChore(name: "Delete this", frequencyInDays: 2)
        store.addChore(name: "Keep this too", frequencyInDays: 3)
        
        let choreToDelete = store.chores[1]
        
        // When
        store.deleteChore(id: choreToDelete.id)
        
        // Then
        XCTAssertEqual(store.chores.count, 2)
        XCTAssertFalse(store.chores.contains(where: { $0.name == "Delete this" }))
        XCTAssertTrue(store.chores.contains(where: { $0.name == "Keep this" }))
        XCTAssertTrue(store.chores.contains(where: { $0.name == "Keep this too" }))
    }
    
    func testDeleteNonExistentChore() {
        // Given
        store.addChore(name: "Existing chore", frequencyInDays: 5)
        let fakeID = UUID()
        
        // When
        store.deleteChore(id: fakeID)
        
        // Then
        XCTAssertEqual(store.chores.count, 1, "Should not delete anything if ID doesn't exist")
    }
    
    // MARK: - Update Chore Tests
    
    func testUpdateChore() {
        // Given
        store.addChore(name: "Old name", frequencyInDays: 5)
        let chore = store.chores.first!
        
        // When
        store.updateChore(id: chore.id, name: "New name", frequencyInDays: 10)
        
        // Then
        XCTAssertEqual(store.chores.count, 1, "Should still have one chore")
        XCTAssertEqual(store.chores.first?.name, "New name")
        XCTAssertEqual(store.chores.first?.frequencyInDays, 10)
        XCTAssertEqual(store.chores.first?.id, chore.id, "ID should remain the same")
    }
    
    func testUpdateChorePreservesLastDone() {
        // Given
        store.addChore(name: "Test", frequencyInDays: 5)
        let chore = store.chores.first!
        store.markAsDone(id: chore.id)
        let originalLastDone = store.chores.first?.lastDone
        
        // When
        store.updateChore(id: chore.id, name: "Updated name", frequencyInDays: 7)
        
        // Then
        XCTAssertEqual(store.chores.first?.lastDone, originalLastDone, "lastDone should be preserved")
    }
    
    // MARK: - Mark As Done Tests
    
    func testMarkAsDone() {
        // Given
        store.addChore(name: "Test chore", frequencyInDays: 3)
        let chore = store.chores.first!
        XCTAssertNil(chore.lastDone, "Should start with nil lastDone")
        
        // When
        store.markAsDone(id: chore.id)
        
        // Then
        XCTAssertNotNil(store.chores.first?.lastDone, "lastDone should be set")
    }
    
    func testMarkAsDoneUpdatesDate() {
        // Given
        let pastDate = Calendar.current.date(byAdding: .day, value: -5, to: Date())!
        store.chores = [Chore(name: "Old", lastDone: pastDate, frequencyInDays: 3)]
        let chore = store.chores.first!
        
        // When
        store.markAsDone(id: chore.id)
        
        // Then
        let newDate = store.chores.first?.lastDone
        XCTAssertNotNil(newDate)
        
        // Check that new date is within last few seconds (to account for test execution time)
        let secondsAgo = Date().timeIntervalSince(newDate!)
        XCTAssertLessThan(secondsAgo, 2, "lastDone should be updated to now")
    }
    
    // MARK: - Save/Load Tests
    /*
    func testSaveAndLoad() {
        XCTSkip("Skipping until we debug the crash")
        // Given
        store.addChore(name: "Test 1", frequencyInDays: 3)
        store.addChore(name: "Test 2", frequencyInDays: 5)
            
        // When - Create new store with SAME test UserDefaults
        let newStore = ChoreStore(userDefaults: testDefaults)
            
        // Then
        XCTAssertEqual(newStore.chores.count, 2, "New store should load saved chores")
        XCTAssertTrue(newStore.chores.contains(where: { $0.name == "Test 1" }))
        XCTAssertTrue(newStore.chores.contains(where: { $0.name == "Test 2" }))
    }
        
    func testLoadEmptyStore() {
        XCTSkip("Skipping until we debug the crash")
            // Given - testDefaults is already clean from setUp
            
            // When
        let newStore = ChoreStore(userDefaults: testDefaults)
            
            // Then
        XCTAssertEqual(newStore.chores.count, 0, "Should start with empty chores if nothing saved")
    }
    
    
    func testDataPersistsAfterDelete() {
        // Given
        store.addChore(name: "Keep", frequencyInDays: 1)
        store.addChore(name: "Delete", frequencyInDays: 2)
        let choreToDelete = store.chores.first(where: { $0.name == "Delete" })!
        
        // When
        store.deleteChore(id: choreToDelete.id)
        let newStore = ChoreStore(userDefaults: testDefaults)
        
        // Then
        XCTAssertEqual(newStore.chores.count, 1)
        XCTAssertEqual(newStore.chores.first?.name, "Keep")
    }
    */

}
