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
    @Published var favouriteEntities: [StudentEntity] = []
    
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
        fetchFavouriteStudents()
    }
    
    //MARK: Function to fetch all the studets records
    func fetchStudents() {
        let request = NSFetchRequest<StudentEntity>(entityName: "StudentEntity")
        do {
            self.savedEntities = try container.viewContext.fetch(request)
        } catch let error{
            print("Error fetching the container \(error)")
        }
    }
    
    //MARK: Function to add student.
    func addStudent(name: String, rollNumber: String, standarad: String, isFavourite: Bool = false, address: String) {
        let newStudent = StudentEntity(context: container.viewContext)
        newStudent.name = name
        newStudent.rollNumber = rollNumber
        newStudent.standard = standarad
        newStudent.isFavourite = isFavourite
        newStudent.address = address
        saveData()
    }
    
    //MARK: Function to mark a student as favourite
    func setStudentAsFavourite(entity: StudentEntity)  {
        entity.isFavourite = true
        saveData()
        fetchFavouriteStudents()
        fetchStudents()
    }
    
    //MARK: Function to unmark studet as favourite
    func setStudentAsNotFavourite(entity: StudentEntity) {
        entity.isFavourite = false
        saveData()
        fetchFavouriteStudents()
        fetchStudents()
    }
    
    //MARK: Function to remove a student
    func removeStudent(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    //MARK: Function to save data to core data.
    func saveData() {
        do {
            try container.viewContext.save()
            //to again update the entities array
            fetchStudents()
            fetchFavouriteStudents()
        } catch let error {
            print("Error Saving the data \(error)")
        }
    }
    
    //MARK: Function to fetch favourite Entities.
    func fetchFavouriteStudents() {
        let request = NSFetchRequest<StudentEntity>(entityName: "StudentEntity")
        request.predicate = NSPredicate(format: "isFavourite == %@", NSNumber(value: true))
        do {
            self.favouriteEntities = try container.viewContext.fetch(request)
        } catch let error{
            print("Error fetching the container \(error)")
        }
    }
}
