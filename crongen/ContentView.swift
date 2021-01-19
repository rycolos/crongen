//  ContentView.swift
//  crongen
//
//  Created by Ryan LaLiberty on 12/14/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var showDaily = false
    @State var showWeekly = false
    @State var showMonthly = false
    @State var showYearly = false
    @State var showXMonth = false
    @State var showXHour = false
    @State var showXMinute = false
    @State var learnCron = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Spacer()
                HStack{
                    Text("crontab generator")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .font(.largeTitle)
                        .padding(.all, 25)
                        .minimumScaleFactor(0.6)
                    Spacer()
                }
                HStack{
                    Text("Select an option to generate a crontab expression.")
                        .padding([.leading, .trailing], 25)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                Spacer()
                Group {
                    Button(action: {
                        self.showDaily.toggle()
                    }) {
                        HStack {
                            Image(systemName: "calendar")
                                .imageScale(.large)
                            Text("Daily at...")
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        .modifier(ButtonModifier(color: Color("cronDaily")))
                    }.sheet(isPresented: $showDaily) {
                        showDailyView(showDaily: self.$showDaily)
                    }
                    .padding([.leading, .trailing])
                    
                    Button(action: {
                        self.showWeekly.toggle()
                    }) {
                        HStack {
                            Image(systemName: "calendar")
                                .imageScale(.large)
                            Text("Weekly on...")
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        .modifier(ButtonModifier(color: Color("cronWeekly")))
                    }.sheet(isPresented: $showWeekly) {
                        showWeeklyView(showWeekly: self.$showWeekly)
                    }
                    .padding([.leading, .trailing])
                    
                    Button(action: {
                        self.showMonthly.toggle()
                    }) {
                        HStack {
                            Image(systemName: "calendar")
                                .imageScale(.large)
                            Text("Monthly on...")
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        .modifier(ButtonModifier(color: Color("cronMonthly")))
                    }.sheet(isPresented: $showMonthly) {
                        showMonthlyView(showMonthly: self.$showMonthly)
                    }
                    .padding([.leading, .trailing])
                    
                    Button(action: {
                        self.showYearly.toggle()
                    }) {
                        HStack {
                            Image(systemName: "calendar")
                                .imageScale(.large)
                            Text("Yearly on...")
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        .modifier(ButtonModifier(color: Color("cronYearly")))
                    }.sheet(isPresented: $showYearly) {
                        showYearlyView(showYearly: self.$showYearly)
                    }
                    .padding([.leading, .trailing])
                    
                    
                    Button(action: {
                        self.showXMonth.toggle()
                    }) {
                        HStack {
                            Image(systemName: "calendar")
                                .imageScale(.large)
                            Text("Every __ months...")
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        .modifier(ButtonModifier(color: Color("cronXMonth")))
                    }.sheet(isPresented: $showXMonth) {
                        showXMonthView(showXMonth: self.$showXMonth)
                    }
                    .padding([.leading, .trailing])
                    
                    Button(action: {
                        self.showXHour.toggle()
                    }) {
                        HStack {
                            Image(systemName: "calendar")
                                .imageScale(.large)
                            Text("Every __ hours...")
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        .modifier(ButtonModifier(color: Color("cronXHour")))
                    }.sheet(isPresented: $showXHour) {
                        showXHourView(showXHour: self.$showXHour)
                    }
                    .padding([.leading, .trailing])
                    
                    Button(action: {
                        self.showXMinute.toggle()
                    }) {
                        HStack {
                            Image(systemName: "calendar")
                                .imageScale(.large)
                            Text("Every __ minutes...")
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        .modifier(ButtonModifier(color: Color("cronXMinute")))
                    }.sheet(isPresented: $showXMinute) {
                        showXMinuteView(showXMinute: self.$showXMinute)
                    }
                    .padding([.leading, .trailing])
                
                }
                
                Link(destination: URL(string: "https://linux.die.net/man/1/crontab")!) {
                    Image(systemName: "questionmark.circle")
                        .font(.title2)
                    Text("crontab man page")
                }
                .foregroundColor(.secondary)
                .padding()
                Spacer()
                
                }
            .frame(maxWidth: .infinity)
        }
        .background(Color(UIColor.systemBackground))
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
    
struct ButtonModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
       return content
        .foregroundColor(.white)
        .frame(maxWidth: 380)
        .padding(.all, 25)
        .background(color)
        .cornerRadius(20)
    }
}
    
struct showDailyView: View {
    @Binding var showDaily: Bool
    @State private var selectedTime = Date(timeIntervalSinceReferenceDate: 18000)
    @State private var cronArray:[String] = ["0", "0", "*", "*", "*"]
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Description")) {
                    Text("Execute a task daily at this time.")
                        .padding(.all, 10)
                }
                Section(header: Text("Time of day")) {
                    DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        //.padding(.all, 10)
                        .frame(height: 120)
                    }
                .accentColor(.primary)
                
                }
            .navigationBarTitle("Daily At...")
            .navigationBarItems(leading: Button(action: {self.showDaily = false}) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.primary)
                    .padding()
            })
                                
            .labelsHidden()
        }
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)

            Text("\(dateComponents.minute!) \(dateComponents.hour!) \(cronArray[2]) \(cronArray[3]) \(cronArray[4])")
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .font(.system(size: 26, design: .monospaced))
                .padding()
                .background(Color(UIColor.systemBackground))
    }
}
    
struct showWeeklyView: View {
    @Binding var showWeekly: Bool
    @State private var selectedTime = Date(timeIntervalSinceReferenceDate: 18000)
    @State private var cronArray:[String] = ["0", "0", "*", "*", "MON"]
    @State private var daySelect = 1
    let daySelection = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Description")) {
                    Text("Execute a task weekly on this day, at this time.")
                        .padding(.all, 10)
                }
                Section(header: Text("Day of the week")) {
                    Picker("", selection: $daySelect) {
                        ForEach(0..<daySelection.count) {
                            Text("\(self.daySelection[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.all, 5)
                Section(header: Text("Time of day")) {
                    DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        //.padding(.all, 10)
                        .frame(height: 120)
                    }
                .accentColor(.primary)
                }
                .navigationBarTitle("Weekly On...")
                .navigationBarItems(leading: Button(action: {self.showWeekly = false}) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.primary)
                        .padding()
                })
                
                .labelsHidden()
        
        }
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)

            Text("\(dateComponents.minute!) \(dateComponents.hour!) \(cronArray[2]) \(cronArray[3]) \(daySelection[daySelect])")
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .font(.system(size: 26, design: .monospaced))
                .padding()
                .background(Color(UIColor.systemBackground))
        }
}
    
struct showMonthlyView: View {
    @Binding var showMonthly: Bool
    @State private var selectedTime = Date(timeIntervalSinceReferenceDate: 18000)
    @State private var cronArray:[String] = ["0", "0", "1", "*", "*"]
    @State private var daySelect = 0
    let daySelection = [
        "1", "2", "3", "4", "5", "6",
        "7", "8", "9", "10", "11", "12",
        "13", "14", "15", "16", "17", "18",
        "19", "20", "21", "22", "23", "24",
        "25", "26", "27", "28", "29", "30",
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Description")) {
                    Text("Execute a task every month, on this day of the month, at this time.")
                        .padding(.all, 10)
                }
                Section(header: Text("Day of the month")) {
                    Picker("", selection: $daySelect) {
                        ForEach(0..<daySelection.count) {
                            Text("\(self.daySelection[$0])")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 120)
                }
                Section(header: Text("Time of day")) {
                    DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        //.padding(.all, 10)
                        .frame(height: 120)
                    }
                    .accentColor(.primary)
            }
            
            .navigationBarTitle("Monthly On...")
            .navigationBarItems(leading: Button(action: {self.showMonthly = false}) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.primary)
                    .padding()
                })
            .labelsHidden()
        }
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)

        Text("\(dateComponents.minute!) \(dateComponents.hour!) \(daySelection[daySelect]) \(cronArray[3]) \(cronArray[4])")
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .font(.system(size: 26, design: .monospaced))
            .padding()
            .background(Color(UIColor.systemBackground))
        
        }
}

struct showYearlyView: View {
    @Binding var showYearly: Bool
    @State private var selectedTime = Date(timeIntervalSinceReferenceDate: 18000)
    @State private var cronArray:[String] = ["0", "0", "1", "JAN", "*"]
    @State private var daySelect = 0
    @State private var monthSelect = 0
    let daySelection = [
        "1", "2", "3", "4", "5", "6",
        "7", "8", "9", "10", "11", "12",
        "13", "14", "15", "16", "17", "18",
        "19", "20", "21", "22", "23", "24",
        "25", "26", "27", "28", "29", "30",
    ]
    let monthSelection = [
        "JAN", "FEB", "MAR", "APR",
        "MAY", "JUN", "JUL", "AUG",
        "SEP", "OCT", "NOV", "DEC",
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Description")) {
                    Text("Execute a task yearly on this month, on this day of the month, at this time.")
                        .padding(.all, 10)
                }
                Section(header: Text("Month")) {
                    Picker("", selection: $monthSelect) {
                        ForEach(0..<monthSelection.count) {
                            Text("\(self.monthSelection[$0])")
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 120)
                }
                Section(header: Text("Day of the month")) {
                    Picker("", selection: $daySelect) {
                        ForEach(0..<daySelection.count) {
                            Text("\(self.daySelection[$0])")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 120)
                }
                Section(header: Text("Time of day")) {
                    DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        //.padding(.all, 10)
                        .frame(height: 120)
                    }
                .accentColor(.primary)
            }
            .navigationBarTitle("Yearly On...")
            .navigationBarItems(leading: Button(action: {self.showYearly = false}) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.primary)
                    .padding()
            })
            .labelsHidden()
            }

            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)

            Text("\(dateComponents.minute!) \(dateComponents.hour!) \(daySelection[daySelect]) \(monthSelection[monthSelect]) \(cronArray[4])")
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .font(.system(size: 26, design: .monospaced))
                .padding()
                .background(Color(UIColor.systemBackground))
            }
}

struct showXMonthView: View {
    @Binding var showXMonth: Bool
    @State private var selectedTime = Date(timeIntervalSinceReferenceDate: 18000)
    @State private var cronArray:[String] = ["0", "0", "1", "*/1", "*"]
    @State private var daySelect = 0
    @State private var monthSelect = 0
    let daySelection = [
        "1", "2", "3", "4", "5", "6",
        "7", "8", "9", "10", "11", "12",
        "13", "14", "15", "16", "17", "18",
        "19", "20", "21", "22", "23", "24",
        "25", "26", "27", "28", "29", "30",
    ]
    let monthSelection = [
        "2", "3", "4", "5", "6",
        "7", "8", "9", "10", "11",
        "12",
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Description")) {
                    Text("Execute a task every X months at this day of the month, at this time.")
                        .padding(.all, 10)
                }
                Section(header: Text("Months between execution")) {
                    Picker("", selection: $monthSelect) {
                        ForEach(0..<monthSelection.count) {
                            Text("\(self.monthSelection[$0])")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 120)
                }
                Section(header: Text("Day of the month")) {
                    Picker("", selection: $daySelect) {
                        ForEach(0..<daySelection.count) {
                            Text("\(self.daySelection[$0])")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 120)
                }
                Section(header: Text("Time of day")) {
                    DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        //.padding(.all, 10)
                        .frame(height: 120)
                    }
                .accentColor(.primary)
            }
            .navigationBarTitle("Every __ months...")
            .navigationBarItems(leading: Button(action: {self.showXMonth = false}) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.primary)
                    .padding()
            })
            .labelsHidden()
        }
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)

        Text("\(dateComponents.minute!) \(dateComponents.hour!) \(daySelection[daySelect]) */\(monthSelection[monthSelect]) \(cronArray[4])")
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .font(.system(size: 26, design: .monospaced))
            .padding()
            .background(Color(UIColor.systemBackground))
        }
}

struct showXHourView: View {
    @Binding var showXHour: Bool
    @State private var cronArray:[String] = ["*", "1", "*", "*", "*"]
    @State private var hourSelect = 0
    let hourSelection = [
        "1", "2", "3", "4", "5", "6",
        "7", "8", "9", "10", "11", "12",
        "13", "14", "15", "16", "17", "18",
        "19", "20", "21", "22", "23",
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Description")) {
                    Text("Execute a task every X hours.")
                        .padding(.all, 10)
                }
                Section(header: Text("Hours between execution")) {
                    Picker("", selection: $hourSelect) {
                        ForEach(0..<hourSelection.count) {
                            Text("\(self.hourSelection[$0])")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 120)
                }
            }
            .navigationBarTitle("Every __ hours...")
            .navigationBarItems(leading: Button(action: {self.showXHour = false}) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.primary)
                    .padding()
            })
            .labelsHidden()
        }
            Text("\(cronArray[0]) */\(hourSelection[hourSelect]) \(cronArray[2]) \(cronArray[3]) \(cronArray[4])")
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .font(.system(size: 26, design: .monospaced))
                .padding()
                .background(Color(UIColor.systemBackground))
        }
}
    
struct showXMinuteView: View {
    @Binding var showXMinute: Bool
    @State private var cronArray:[String] = ["0", "*", "*", "*", "*"]
    @State private var minuteSelect = 0
    let minuteSelection = [
        "1", "2", "3", "4", "5", "6",
        "7", "8", "9", "10", "11", "12",
        "13", "14", "15", "16", "17", "18",
        "19", "20", "21", "22", "23", "24",
        "25", "26", "27", "28", "29", "30",
        "31", "32", "33", "34", "35", "36",
        "37", "38", "39", "40", "41", "42",
        "43", "44", "45", "46", "47", "48",
        "49", "50", "51", "52", "53", "54",
        "55", "56", "57", "58", "59",
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Description")) {
                    Text("Execute a task every X minutes.")
                        .padding(.all, 10)
                }
                Section(header: Text("Minutes between execution")) {
                    Picker("", selection: $minuteSelect) {
                        ForEach(0..<minuteSelection.count) {
                            Text("\(self.minuteSelection[$0])")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 120)
                    
                }
            }
            .navigationBarTitle("Every __ minutes...")
            .navigationBarItems(leading: Button(action: {self.showXMinute = false}) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.primary)
                    .padding()
            })
            .labelsHidden()
        }
            Text("*/\(minuteSelection[minuteSelect]) \(cronArray[1]) \(cronArray[2]) \(cronArray[3]) \(cronArray[4])")
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .font(.system(size: 26, design: .monospaced))
                .padding()
                .background(Color(UIColor.systemBackground))
        }
}

}


