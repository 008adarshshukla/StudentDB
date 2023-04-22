//
//  ContentView.swift
//  StudentDB
//
//  Created by Adarsh Shukla on 22/04/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if coreDataViewModel.savedEntities.count == 0 {
                    addStudentView()
                }
                else {
                    List {
                        
                    }
                }
            }
            //MARK: Navigation Bar Item.
            .toolbar(content: {
                //MARK: Trailing Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
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

