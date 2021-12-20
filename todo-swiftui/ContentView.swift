//
//  ContentView.swift
//  todo-swiftui
//
//  Created by Pedrito Holiiss on 19/12/21.
//

import SwiftUI

struct Todo: Identifiable {
    let id = UUID()
    let text: String
}

struct ContentView: View {
    
    @State var todos = [Todo(text: "hola"), Todo(text: "amigos"), Todo(text: "minecraft")]
    
    @State var isOpen = false
    
    @State var inputText: String = ""
    
    func deleteTodo(id: UUID) -> Void {
        self.todos = self.todos.filter { $0.id != id }
    }
    
    func addTodo(text: String) -> Void {
        if(text.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return
        }
        let newTodo = Todo(text: text)
        self.todos.append(newTodo)
    }
    
    func openDialog() {
        self.isOpen = true
    }
    
    func closeDialog() {
        self.inputText = ""
        self.isOpen = false
    }
    
    var body: some View {
        NavigationView {
            List(todos) { todo in
                HStack {
                    Text(todo.text)
                    Spacer()
                    Button(action: {
                        deleteTodo(id: todo.id)
                    }, label: {
                        Text("Delete")
                    })
                }
            }
            .navigationBarTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        openDialog()
                    }, label: {Image(systemName: "pencil")})
                        .buttonStyle(.bordered)
                }
            }.sheet(isPresented: $isOpen, onDismiss: closeDialog) {
                VStack {
                    HStack {
                        Button("Cancel") {
                            closeDialog()
                        }
                        Spacer()
                        Button("Done") {
                            addTodo(text: inputText)
                            closeDialog()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    Text("Add a task")
                        .font(.title)
                        .fontWeight(.semibold)
                    TextField("Type something", text: $inputText)
                    Spacer()
                }
                .padding(16)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
