//
//  Task.swift
//  toDoList
//
//  Created by Pedro Juan Ferreira Saraiva on 20/02/25.
//


import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    var text: String
    var isCompleted: Bool = false
}

struct ContentView: View {
    @State private var tasks: [Task] = []
    @State private var newTask: String = ""
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach(tasks.indices, id: \.self) { index in
                    HStack {
                        Image(systemName: tasks[index].isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(tasks[index].isCompleted ? .green : .gray)
                            .onTapGesture {
                                tasks[index].isCompleted.toggle()
                            }
                        
                        TextField("", text: $tasks[index].text)
                            .strikethrough(tasks[index].isCompleted, color: .gray)
                            .foregroundColor(tasks[index].isCompleted ? .gray : .black)
                        
                        Spacer()
                        
                        if isEditing {
                            Button(action: {
                                removeTask(at: index)
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            
            HStack {
                TextField("Nova tarefa", text: $newTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: addTask) {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
            .padding()
            
            Button(action: {
                isEditing.toggle()
            }) {
                Image(systemName: isEditing ? "pencil.slash" : "pencil")
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
            .padding(.bottom, 10)
        }
    }
    
    private func addTask() {
        guard !newTask.isEmpty else { return }
        tasks.append(Task(text: newTask))
        newTask = ""
    }
    
    private func removeTask(at index: Int) {
        tasks.remove(at: index)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
