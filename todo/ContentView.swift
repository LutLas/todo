//
//  ContentView.swift
//  todo
//
//  Created by Lutaka Muyoba Chihota on 10/14/22.
//

import SwiftUI

struct ContentView: View {
    @State private var todoItemName:String = ""
    @State private var todoItems:[TodoItem] = []
    var body: some View {
        NavigationView{
            VStack {
                
                HStack{
                    TextField(
                        "New Todo...",
                        text:$todoItemName
                    ).textFieldStyle(RoundedBorderTextFieldStyle()).border(Color.blue, width: 2)
                    
                    Button(action: {
                                guard !self.todoItemName.isEmpty else {return}
                                self.todoItems.append(TodoItem(name: self.todoItemName))
                                self.todoItemName = ""
                                self.save()
                        },
                           label: {
                                Image(systemName:"text.badge.plus")
                        }
                    ).padding(.leading,5)
                }.padding()
                
                List{
                    ForEach(self.todoItems){ todoItem in
                        Text("\(todoItem.name)")
                    }.onDelete(perform: delete)
                }
                
            }
            .navigationTitle("Todo List")
        }.onAppear(perform: load)
    }
    private func save(){
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(self.todoItems),
            forKey: "myTodoItemsKey"
        )
    }
    private func load(){
        if let todoItemsData = UserDefaults.standard.value(forKey: "myTodoItemsKey") as? Data {
            if let todoItemsList = try? PropertyListDecoder().decode(Array<TodoItem>.self,from:todoItemsData){
                self.todoItems = todoItemsList
            }
        }
    }
    private func delete(at offset:IndexSet){
        self.todoItems.remove(atOffsets: offset)
        save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
