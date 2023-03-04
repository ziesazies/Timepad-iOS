//
//  Task.swift
//  TimePad
//
//  Created by Alief Ahmad Azies on 03/03/23.
//

import Foundation
import RealmSwift

class Task: Object {
    @Persisted var title: String = ""
    @Persisted var category: String = ""
    @Persisted var tag: String = ""
    @Persisted var start: Date?
    @Persisted var finish: Date?
}

extension Task {
    var categoryType: Category? {
        Category.allCases.first(where: {$0.name == category})
        
    }
    
    var tagType: Tag? {
        Tag.allCases.first(where: {$0.name == tag})
    }
}
