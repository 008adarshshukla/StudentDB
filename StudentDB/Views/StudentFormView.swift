//
//  StudentFormView.swift
//  StudentDB
//
//  Created by Adarsh Shukla on 22/04/23.
//

import SwiftUI

struct StudentFormView: View {
    
    @State private var name: String = ""
    @State private var rollNumber: String = ""
    @State private var standard: String = ""
    @State private var address: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                nameField()
                HStack {
                    rollNumberField()
                    standardField()
                }
                addressField()
                
                Spacer()
                
                submitButton()
                
            }
            .padding(.vertical)
            .navigationTitle("Student Deatils")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .overlay(alignment: .center) {
                                Image(systemName: "xmark")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            
                    }
                }
            }
        }
    }
    
    //MARK: Name Field
    @ViewBuilder
    func nameField() -> some View {
        TextField("Type your name...", text: $name)
            .font(.headline)
            .padding()
            .background(Color.gray.opacity(0.3).cornerRadius(20))
            .padding()
            .textInputAutocapitalization(.words)
            .autocorrectionDisabled()
    }
    
    //MARK: Roll number Field
    @ViewBuilder
    func rollNumberField() -> some View {
        TextField("Roll Number...", text: $rollNumber)
            .font(.headline)
            .padding()
            .background(Color.gray.opacity(0.3).cornerRadius(20))
            .padding()
            .autocorrectionDisabled()
    }
    
    //MARK: Standard Field
    @ViewBuilder
    func standardField() -> some View {
        TextField("Standard...", text: $standard)
            .font(.headline)
            .padding()
            .background(Color.gray.opacity(0.3).cornerRadius(20))
            .padding()
            .autocorrectionDisabled()
    }
    
    //MARK: Address Field
    @ViewBuilder
    func addressField() -> some View {
        TextField("Type your address...", text: $address)
            .font(.headline)
            .padding()
            .background(Color.gray.opacity(0.3).cornerRadius(20))
            .padding()
            .autocorrectionDisabled()
    }
    
    //MARK: Submit Button
    @ViewBuilder
    func submitButton() -> some View {
        Button {
            coreDataViewModel.addStudent(name: name, rollNumber: rollNumber, standarad: standard, address: address)
            dismiss()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(isAnyFieldEmpty() ? .black : .blue)
                .frame(width: UIScreen.main.bounds.width / 2 ,height: 50)
                .overlay(alignment: .center) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
        }
        .disabled(isAnyFieldEmpty())
    }
    
    //MARK: Check if any field is empty.
    func isAnyFieldEmpty() -> Bool {
        return name.isEmpty || rollNumber.isEmpty || standard.isEmpty || address.isEmpty
    }
}

struct StudentFormView_Previews: PreviewProvider {
    static var previews: some View {
        StudentFormView()
            .environmentObject(CoreDataViewModel())
    }
}
