//
//  ContentView.swift
//  SwiftUIDIagram
//
//  Created by Igor on 10.04.2022.
//

import SwiftUI

struct ProgressShape: Shape {
    
    let progress: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: .radians(1.5 * .pi),
                    endAngle: .init(radians: 2 * Double.pi * progress + 1.5 * Double.pi),
                    clockwise: false)
        return path
    }
}

struct ContentView: View {
    
    @State var showProfile = false
    @State var pickerItem = 0
    @State var diagramValues: [[CGFloat]] = [
            [30, 90, 160],
            [50, 180, 80],
            [100, 50, 100]]
    @State var circleValues: [[Double]] = [
        [0.15, 0.45, 0.8],
        [0.25, 0.9, 0.4],
        [0.5, 0.25, 0.5]]
    
    var body: some View {
        ZStack {
            Color(CGColor(red: 1, green: 160 / 255, blue: 145 / 255, alpha: 0.8))
                .edgesIgnoringSafeArea(.all)
            VStack {
                Button {
                    self.showProfile.toggle()
                } label: {
                    Image("user")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                }

                Text("Analitics")
                    .font(.system(size: 32))
                    .fontWeight(.heavy)
                Picker(selection: $pickerItem, label: Text("")) {
                    Text("September").tag(0)
                    Text("October").tag(1)
                    Text("November").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 16)
                
                HStack {
                    CircleView(value: circleValues[pickerItem][0])
                    CircleView(value: circleValues[pickerItem][1])
                    CircleView(value: circleValues[pickerItem][2])
                }.padding(.top, 16)
                    .animation(.easeInOut(duration: 0.3))
                HStack {
                    DiagramView(value: diagramValues[pickerItem][0])
                    DiagramView(value: diagramValues[pickerItem][1])
                    DiagramView(value: diagramValues[pickerItem][2])
                }.padding(.top, 16)
                    .animation(.easeInOut(duration: 1))
                MenuProgress()
                    .offset(y: showProfile ? 0 : 600)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .scaleEffect(showProfile ? 0.9 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .rotation3DEffect(Angle(degrees: showProfile ? -10 : 0), axis: (x: 0, y: 0, z: 0))
            
            /*
            ZStack {
                Rectangle()
                    .fill(Color.cyan)
                    .frame(width: 200, height: 200)
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                Capsule()
                    .fill(Color.green)
                    .frame(width: 50, height: 200)
                Ellipse()
                    .fill(Color.white)
                    .frame(width: 200, height: 50)
                Circle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 50)
            }
             */
        }
    }
}

struct DiagramView: View {
    var value: CGFloat
    
    private var color: Color {
        switch true {
        case value <= 80:
            return .blue
        case value > 80 && value < 130:
            return .green
        default:
            return .red
        }
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .frame(width: 30, height: 200)
                .foregroundColor(Color.white)
                Rectangle()
                    .frame(width: 30, height: value)
//                    .foregroundColor(Color.red)
                    .foregroundColor(color)
            }.padding(.top, 16)
                .padding(.bottom, 32)
        }
    }
}

struct CircleView: View {
    var value: Double
    
    private var color: Color {
        switch true {
        case value <= 0.4:
            return .blue
        case value > 0.4 && value < 0.65:
            return .green
        default:
            return .red
        }
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            ProgressShape(progress: 1)
                .stroke(Color.white, style: StrokeStyle(lineWidth: 10,
                                                        lineCap: .butt,
                                                        lineJoin: .round,
                                                        miterLimit: 0,
                                                        dash: [],
                                                    dashPhase: 0))
            ProgressShape(progress: value)
                .stroke(color, style: StrokeStyle(lineWidth: 10,
                                                        lineCap: .round,
                                                        lineJoin: .round,
                                                        miterLimit: 0,
                                                        dash: [],
                                                    dashPhase: 0))
            Text(String(value * 100))
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
