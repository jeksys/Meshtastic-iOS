//
//  ChatView.swift
//  Meshtastic
//
//  Created by Evgeny Yagrushkin on 2020-10-19.
//

import SwiftUI



struct ChatView: View {
//    @State private var messageInput = ""
//    @State private var chatHistory = ""
    
    var body: some View {
//        VStack {
//            ScrollView {
//                LazyVStack(alignment: .leading, spacing: 32) {
//                    ForEach(0 ..< 12) { _ in
//                        TextField("Lorem Ipsum Lorem Ipsum", text: $chatHistory)
//                    }
//
//                }
//            }
//            TextField("Message", text: $messageInput)
//                .frame(width: 300, height: 40)
//                .font(Font.system(size: 15, weight: .semibold))
//                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
//                .padding()
//        }
        
        
        // Borrowed from KavSoft
        chatInstance()
        
        
        
        
        
        
        
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}


struct chatInstance : View {
    
    @State var txt = ""
    @State var height : CGFloat = 0
    @State var keyboardHeight : CGFloat = 0
    
    var body: some View {
        VStack (spacing: 0) {
            
            HStack {
                Text("Chat")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer()
            }.padding()
            .background(Color.white)
            
            Spacer()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                // Chat Content
                Text("")
            }
            
            HStack(spacing: 8) {
                
                resizeableChat(txt: self.$txt, height: self.$height)
                    .frame(height: self.height < 150 ? self.height : 150)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(15)
                Button(action: {
                    
                }) {
                    
                    Image(systemName: "arrow.forward.circle")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.black)
                        .padding(10)
                }
                .background(Color.white)
                .clipShape(Circle())
            }
            .padding(.horizontal)
            
        }
        .padding(.bottom, self.keyboardHeight)
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.bottom)
                        .onTapGesture {
                            
                            UIApplication.shared.windows.first?.rootViewController?.view
                                .endEditing(true)
                        })
        .onAppear {
            
            NotificationCenter.default.addObserver(forName:
                                                    UIResponder.keyboardDidShowNotification, object: nil, queue: .main) {
                (data) in
                
                let height1 = data.userInfo![UIResponder.keyboardFrameEndUserInfoKey]
                    as! NSValue
                
                self.keyboardHeight = height1.cgRectValue.height - 20
                
            }
            
            NotificationCenter.default.addObserver(forName:
                                                    UIResponder.keyboardDidHideNotification, object: nil, queue: .main) {
                (_) in
                
                self.keyboardHeight = 0
                
            }
        }
    }
}


struct resizeableChat : UIViewRepresentable {
    
    @Binding var txt: String
    @Binding var height : CGFloat
    
    func makeCoordinator() -> Coordinator {
        
        return resizeableChat.Coordinator(parent1: self)
    }
    
    
    func makeUIView(context: Context) -> UITextView {
        
        let view = UITextView()
        view.isEditable = true
        view.isScrollEnabled = true
        view.text = "Enter Message"
        view.font = .systemFont(ofSize: 18)
        view.textColor = .gray
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            
            self.height = uiView.contentSize.height
        }
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        
        var parent : resizeableChat
        
        init(parent1 : resizeableChat) {
            
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            
            if self.parent.txt == "" {
                
                textView.text = ""
                textView.textColor = .black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if self.parent.txt == ""{
                
                textView.text = "Enter Message"
                textView.textColor = .gray
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.txt = textView.text
                
            }
        }
    }
}
