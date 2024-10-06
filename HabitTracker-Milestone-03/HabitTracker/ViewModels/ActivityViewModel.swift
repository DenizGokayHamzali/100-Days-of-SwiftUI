//  Created by Deniz Gökay Hamzalı on 6.10.2024.

class ActivityViewModel {
    var activities: [Activity] = []
    
    init() {
        
    }
    
    func addAcvitiy(_ activity: Activity) {
        activities.append(activity)
    }
}
