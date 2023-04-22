//
//  CoreDataViewModel.swift
//  StudentDB
//
//  Created by Adarsh Shukla on 22/04/23.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [StudentEntity] = []
    
    //MARK: Intialisation and setting up Core data constaner.
    init() {
        container = NSPersistentContainer(name: "StudentsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Erroe Loading Core Data \(error)")
            }else {
                print("Successfully loaded Core Data.")
            }
        }
        
        fetchStudents()
    }
    
    //MARK: Function to fetch all the studets records
    func fetchStudents() {
        let request = NSFetchRequest<StudentEntity>(entityName: "StudentEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error{
            print("Error fetching the container \(error)")
        }
    }
    
    func addStudent(name: String, rollNumber: String, standarad: String, isFavourite: Bool = false, address: String) {
        let newStudent = StudentEntity(context: container.viewContext)
        newStudent.name = name
        newStudent.rollNumber = rollNumber
        newStudent.standard = standarad
        newStudent.isFavourite = isFavourite
        newStudent.address = address
        saveData()
    }
    
    func updateStudent(entity: StudentEntity)  {
        var  currentName = entity.name ?? ""
        currentName += "!"
        entity.name = currentName
        saveData()
    }
    
    func removeStudent(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            //to again update the entities array
            fetchStudents()
        } catch let error {
            print("Error Saving the data \(error)")
        }
    }
}
