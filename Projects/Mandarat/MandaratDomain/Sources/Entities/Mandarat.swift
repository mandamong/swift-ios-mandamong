/// 목표별 행동 아이디어
struct ActionItem: Identifiable {
    let id: UInt
    var action: String
    var isCompleted: Bool
    
    init(id: UInt, action: String = String(), isCompleted: Bool = false) {
        self.id = id
        self.action = action
        self.isCompleted = isCompleted
    }
}
