//
//  StudentRowView.swift
//  StudentDB
//
//  Created by Adarsh Shukla on 22/04/23.
//

import SwiftUI

struct StudentRowView: View {
    
    let entity: StudentEntity
    let isFavouriteList: Bool
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                
                Text(entity.name ?? "")
                    .font(.title2)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                
                Text(entity.rollNumber ?? "")
                    .font(.body)
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                
                
                Text("Standard : \(entity.standard ?? "")")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                
                Text(entity.address ?? "")
                    .font(.body)
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
            }
            if !isFavouriteList {
                Group {
                    Spacer()
                    Button {
                        if entity.isFavourite {
                            coreDataViewModel.setStudentAsNotFavourite(entity: entity)
                        }
                        else {
                            coreDataViewModel.setStudentAsFavourite(entity: entity)
                        }
                    } label: {
                        Image(systemName: "star.fill")
                            .font(.title2)
                            .foregroundColor(entity.isFavourite ? .yellow : .gray)
                    }
                    .buttonStyle(.borderless)
                }
            }
        }
    }
}


struct StudentRowView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(CoreDataViewModel())
    }
}
