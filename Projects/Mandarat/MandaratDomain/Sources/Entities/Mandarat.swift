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

/// 핵심 주제별 목표
struct Objective: Identifiable {
    let id:  UInt
    var content: String
    var actionItems: [ActionItem]
    
    init(id: UInt, content: String = String(), actionItems: [ActionItem] = []) {
        self.id = id
        self.content = content
        self.actionItems = actionItems
    }
}

/// 핵심 주제
struct Subject: Identifiable {
    let id: UInt
    var content: String
    var isCompleted: Bool
    
    init(id: UInt, content: String = String(), isCompleted: Bool = false) {
        self.id = id
        self.content = content
        self.isCompleted = isCompleted
    }
}

