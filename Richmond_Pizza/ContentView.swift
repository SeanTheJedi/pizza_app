//
//  ContentView.swift
//  Richmond_Pizza
//
//  Created by Richmond Gyimah on 02/02/2024.
//

import SwiftUI



struct ContentView: View {

    //state variables
    @State private var order = Order()
    @State private var errorMessage1:String? = nil
    @State private var errorMessage2:String? = nil
    @State private var showAlert : Bool = false
    @State private var finalCost: Double = 0.0
   
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing:30) {
                    VStack(alignment: .leading, spacing:8) {
                        Text("Order Details").bold().font(.title2)
                        Toggle("Vegiterian", isOn: $order.isVegeterian)
                        HStack {
                            Text("Size")
                            Spacer()
                            Picker("Size", selection: $order.selectedSize) {
                                Text("Small").tag(Size.small)
                                Text("Medium").tag(Size.medium)
                                Text("Large").tag(Size.large)
                                Text("Extra-Large").tag(Size.extraLarge)
                                }//Picker
                        }//HStack
                    
                        Stepper ("Number", value: $order.quantity, in: 1...5)
                        Text("Quantity of Pizzas: \(order.quantity)")
                    }//VStack
                    
                    VStack(alignment: .leading, spacing:8) {
                        Text("Customer Details").bold().font(.title2)
                        TextField("Customer's Name", text:$order.customerName)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.default)
                        TextField("Customer's Phone Number", text:$order.customerPhone)
                            .keyboardType(.numberPad)
                        
                        if let errMsg = errorMessage1 {
                            Text(errMsg)
                                .foregroundColor(.red)
                        }
                    }//VStack
                    
                    VStack(alignment: .leading, spacing:8) {
                        Text("Coupon Details").bold().font(.title2)
                        TextField("Coupon Code", text:$order.couponCode)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                    
                        if let errMsg = errorMessage2 {
                            Text(errMsg)
                                .foregroundColor(.red)
                        }
                    }//VStack
                    
                    HStack(alignment: .center) {
                        Spacer()
                        Button {
                            self.placeOrder(orderInfo: self.order)
                        } label: {
                            Text("Place order").bold()
                        }
                        .padding(.vertical, 14)
                        .padding(.horizontal, 25)
                        .alert(isPresented: self.$showAlert){
                            Alert(title: Text("Order Details"),
                                  message:
                                    Text("\(order.orderDetails)\n" + "Pre-Tax Cost: $\(String(format: "%.2f", order.calculateCost()))\n" +
                                                "Tax: 13%" + "\nFinal Cost: $\(String(format: "%.2f", self.finalCost))"),
                                  dismissButton: .default(Text("Dismiss")){
                                print("alert dismissed")
                            })
                        }
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.orange/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        Spacer()

                    }//HStack
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    Spacer()
                
                }//VStack
                
            }//ScrollView

            .navigationTitle("Richmond_Pizza")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Menu{
                        Button("Daily Special"){
                            self.order.selectedSize = .large
                            self.order.quantity = 2
                            self.order.isVegeterian = false
                            self.order.couponCode = "OFFERSPECIAL"
                        }
                        Button{
                            self.order = Order()
                            
                        }label: {
                            Text("Reset")
                                .foregroundColor(Color.red)
                                
                        }
                        
                        
                    }//Menu
                    label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(Color(.orange))
                    }//Menu label
                }//ToolbarItem
            }
            .padding()
            
            
        }
        //NavigationStack
        
    }
    
    private func placeOrder(orderInfo: Order)  {
        
        //checking  empty fields
        if (orderInfo.customerName == "" || orderInfo.customerPhone == "") {
            self.errorMessage1 = "All customer details must be entered"
            return
        } else {
            self.errorMessage1 = nil
        }
        
        //checking for invalid coupons
        if (orderInfo.couponCode != "") {
            if (orderInfo.couponCode.hasPrefix("OFFER") == false) {
                self.errorMessage2 = "Invalid coupon code entered"
                return
            } else {
                self.errorMessage2 = nil
            }
        } else {
            self.errorMessage2 = nil
        }
        
        // calculating final cost
        var taxAmt = orderInfo.calculateCost() * 0.13
        self.finalCost = orderInfo.calculateCost() + taxAmt
        
        self.showAlert = true
        
        
        
    }
}

#Preview {
    ContentView()
}
