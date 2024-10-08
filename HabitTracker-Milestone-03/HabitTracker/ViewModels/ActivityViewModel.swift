//  Created by Deniz Gökay Hamzalı on 6.10.2024.
import Foundation

@Observable
class ActivityViewModel {
    var activities: [Activity] = []
    
    init() {
        loadActivities()
    }
    
    func addActivity(_ activity: Activity) {
        activities.append(activity)
        saveActivities()
    }
    
    private func saveActivities() {
        if let encoded = try? JSONEncoder().encode(activities) {
            UserDefaults.standard.set(encoded, forKey: "Activities")
        }
    }
    
    private func loadActivities() {
        if let savedActivities = UserDefaults.standard.data(forKey: "Activities") {
            if let decodedActivities = try? JSONDecoder().decode([Activity].self, from: savedActivities) {
                activities = decodedActivities
            }
        }
    }
    
    func incrementCompletionCount(for activity: Activity) {
        if let index = activities.firstIndex(of: activity) {
            activities[index].completionCount += 1
            saveActivities()
        }
    }
}
