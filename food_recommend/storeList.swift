struct StoreList {
    let id: String
    let name: String
    let addr: String
    let len : Double
    let food : String
}

extension StoreList {
    // 정적함수를 이용하여 모든 데이터를 가져옵니다.
    static func all() -> [StoreList] {
        return [
            StoreList(id: "1", name: "가게1", addr: "마포구 22", len: 1.25, food: "피자"),
            StoreList(id: "2", name: "가게2", addr: "대흥로 110", len: 0.25, food: "피자"),
            StoreList(id: "3", name: "가게3", addr: "신수동 1-1번지", len: 1.00, food: "팬케이크"),
            StoreList(id: "4", name: "가게4", addr: "신수동 1-1번지", len: 1.00, food: "연어 스테이크"),
            StoreList(id: "5", name: "가게5", addr: "대흥로 110", len: 0.25, food: "피자"),
            StoreList(id: "6", name: "가게6", addr: "대흥로 110", len: 0.25, food: "피자"),
        ]
    }
}
