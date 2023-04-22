//
//  ContentView.swift
//  StudentDB
//
//  Created by Adarsh Shukla on 22/04/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    @State private var showFormView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if coreDataViewModel.savedEntities.count == 0 {
                    addStudentView()
                }
                else {
                    List {
                        Section {
                            ForEach(coreDataViewModel.savedEntities) { entity in
                                StudentRowView(entity: entity, isFavouriteList: false)
                            }
                            .onDelete { indexSet in
                                coreDataViewModel.removeStudent(indexSet: indexSet)
                            }
                        } header: {
                            Text("All Students")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        
                        Section {
                            ForEach(coreDataViewModel.favouriteEntities) { entity in
                                StudentRowView(entity: entity, isFavouriteList: true)
                            }
                        } header: {
                            Text("Favourite Students")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                    }
                }
            }
            //MARK: Navigation Bar Item.
            .toolbar(content: {
                //MARK: Trailing Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showFormView = true
                    } label: {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .shadow(radius: 3)
                            .overlay(alignment: .center) {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            
                    }
                }
                
                //MARK: Leading Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .overlay(alignment: .center) {
                                Image(systemName: "line.3.horizontal")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            
                    }
                }
            })
            .navigationTitle("Students")
        }
        .fullScreenCover(isPresented: $showFormView) {
            StudentFormView()
        }
    }
    
    //MARK: Add student View...
    @ViewBuilder
    func addStudentView() -> some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                Image("Student")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 50)
                
                VStack(alignment: .center) {
                    Text("No students added yet!!")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text("Click to add students!!")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        showFormView = true
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.width / 2 ,height: 50)
                            .overlay(alignment: .center) {
                                Text("Add Student")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(CoreDataViewModel())
    }
}

