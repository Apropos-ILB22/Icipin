//
//  ContentView.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 15/08/22.
//

import SwiftUI
import HalfASheet

struct ContentView: View {
    
    @State private var showWelcomeModal = false
    @State private var showQuestModal = false
    @State private var showQuestClueModal = false
    @State private var showToScanModal = false
    @State private var showToScanClueModal = false
    
    var body: some View {
        ZStack{
            VStack{
                Button{
                    showWelcomeModal = true
                } label: {
                    Text("Welcome")
                }
                .buttonStyle(.borderedProminent)
                Button{
                    showQuestModal = true
                } label: {
                    Text("Show Quest")
                }
                .buttonStyle(.borderedProminent)
                Button{
                    showToScanModal = true
                } label: {
                    Text("Start Journey")
                }
                .buttonStyle(.borderedProminent)
            }
            //            WelcomeView(isShowing: $showWelcomeModal)
            //            QuestView(isShowing: $showQuestModal)
            HalfASheet(isPresented: $showWelcomeModal) {
                VStack(alignment: .leading){
                    Text("Hai, Pemburu Kuliner!").fontWeight(.bold).font(.title2)
                    Text("Banyak quest menarik menunggu kamu nih! Ayo mulai perjalananmu dengan menekan salah satu quest!").fontWeight(.medium).font(.title3)
                }
            }
            .height(.fixed(150))
            .closeButtonColor(.white)
            .backgroundColor(.white)
            .contentInsets(EdgeInsets(top: 20, leading: 0, bottom: 5, trailing: 0))
            
            HalfASheet(isPresented: $showQuestModal) {
                questView
            }
            .height(.fixed(150))
            .closeButtonColor(.white)
            .backgroundColor(.white)
            .contentInsets(EdgeInsets(top: 20, leading: 0, bottom: -30, trailing: 0))
            
            HalfASheet(isPresented: $showQuestClueModal) {
                questClueView
            }
            .height(.fixed(500))
            .closeButtonColor(.white)
            .backgroundColor(.white)
            .contentInsets(EdgeInsets(top: 20, leading: 0, bottom: -50, trailing: 0))
            
            HalfASheet(isPresented: $showQuestClueModal) {
                questClueView
            }
            .height(.fixed(550))
            .closeButtonColor(.white)
            .backgroundColor(.white)
            .contentInsets(EdgeInsets(top: 20, leading: 0, bottom: -50, trailing: 0))
            
            HalfASheet(isPresented: $showToScanModal) {
                toScanView
            }
            .height(.fixed(150))
            .closeButtonColor(.white)
            .backgroundColor(.white)
            .contentInsets(EdgeInsets(top: 20, leading: 0, bottom: -50, trailing: 0))
            
            HalfASheet(isPresented: $showToScanClueModal) {
                toScanClueView
            }
            .height(.fixed(550))
            .closeButtonColor(.white)
            .backgroundColor(.white)
            .contentInsets(EdgeInsets(top: 20, leading: 0, bottom: -50, trailing: 0))
        }
    }
    
    var questView: some View {
        VStack{
            HStack {
                VStack (alignment: .leading){
                    HStack{
                        Image("test_bolagurita")
                            .resizable()
                            .frame(width: 55, height: 55)
                            .padding(.leading,30)
                        VStack(alignment: .leading) {
                            Text("Bola Gurita").fontWeight(.bold).font(.title2)
                            Text("Cemilan").fontWeight(.medium).font(.title3)
                        }
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.red)
                        Text("2.5 km").fontWeight(.medium).font(.body)
                        Image(systemName: "clock")
                            .foregroundColor(.blue)
                        Text("15 mnt").fontWeight(.medium).font(.body)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("4(5)").fontWeight(.medium).font(.body)
                    }
                    .padding(.leading,30)
                }
                Button(action: {
                    //show clue
                    showQuestClueModal = true
                    
                }, label: {
                    Image(systemName: "key")
                        .font(.title2)
                })
                .padding(15)
                .foregroundColor(.white)
                .background(Color("PrimaryColor"))
                .cornerRadius(11)
                .padding(.trailing,30)
            }
            Button(action: {
                //quest
            }, label: {
                Text("Pilih Quest")
                    .font(.body)
                    .bold()
            })
            .frame(width: UIScreen .main.bounds.width-20, height: 58, alignment: .center)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .background(Color("PrimaryColor"))
            .cornerRadius(20)
        }
        .padding(.bottom,25)
    }
    
    var questClueView: some View {
        VStack(alignment: .leading){
            HStack {
                VStack (alignment: .leading){
                    HStack{
                        Image("test_bolagurita")
                            .resizable()
                            .frame(width: 55, height: 55)
                            .padding(.leading,30)
                        VStack(alignment: .leading) {
                            Text("Bola Gurita").fontWeight(.bold).font(.title2)
                            Text("Cemilan").fontWeight(.medium).font(.title3)
                        }
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.red)
                        Text("2.5 km").fontWeight(.medium).font(.body)
                        Image(systemName: "clock")
                            .foregroundColor(.blue)
                        Text("15 mnt").fontWeight(.medium).font(.body)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("4(5)").fontWeight(.medium).font(.body)
                    }
                    .padding(.leading,30)
                }
                Button(action: {
                    //hide clue
                    showQuestClueModal = false
                    showQuestModal = true
                }, label: {
                    Image(systemName: "chevron.down")
                        .font(Font.system(size: 33, weight: .bold))
                })
                .foregroundColor(Color("PrimaryColor"))
                .cornerRadius(11)
                .padding(.trailing,20)
                
            }
            Divider().frame(maxWidth:UIScreen.main.bounds.width-20, maxHeight:10)
            VStack (alignment: .leading){
                Text("Petunjuk")
                    .fontWeight(.bold).font(.title2)
                    .padding(.leading,30)
                Text("Makanan Khas Jepang")
                    .font(.title3)
                    .padding(.leading,30)
                    .padding(.top,5)
                    .padding(.bottom,5)
                Text("Terbuat dari tepung dan gurita")
                    .font(.title3)
                    .padding(.leading,30)
                    .padding(.top,5)
                    .padding(.bottom,5)
                Text("Bentuknya seperti bola pingpong, biasa di sajikan bersama mayonaise dan serbuk ikan")
                    .font(.title3)
                    .padding(.leading,30)
                    .padding(.top,5)
                    .padding(.bottom,5)
                Text("Rasanya gurih dan agak manis dari mayonaise")
                    .font(.title3)
                    .padding(.leading,30)
                    .padding(.top,5)
                    .padding(.bottom,5)
            }
            .padding(.bottom,30)
            HStack{
                Spacer()
                Button(action: {
                    //quest
                }, label: {
                    Text("Pilih Quest")
                        .font(.body)
                        .bold()
                })
                .frame(width: UIScreen.main.bounds.width-20, height: 58, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .background(Color("PrimaryColor"))
                .cornerRadius(20)
                Spacer()
            }
        }
        .padding(.bottom,25)
    }
    
    var toScanView: some View {
        VStack{
            HStack {
                VStack (alignment: .leading){
                    HStack{
                        VStack(alignment: .leading) {
                            HStack{
                                Text("10 mnt").fontWeight(.bold).font(.title).foregroundColor(.blue)
                                Text("(2.5 km)").fontWeight(.medium).font(.title3)
                            }
                            Text("menuju BOLA GURITA").fontWeight(.medium).font(.title3)
                        }
                        Spacer()
                    }
                    .padding(.leading,30)
                }
                Button(action: {
                    //show clue
                    showToScanModal = false
                    showToScanClueModal = true
                }, label: {
                    Image(systemName: "key")
                        .font(.title2)
                })
                .padding(15)
                .foregroundColor(.white)
                .background(Color("PrimaryColor"))
                .cornerRadius(11)
                .padding(.trailing,20)
                
            }
            Button(action: {
                //quest
            }, label: {
                Text("Pilih Quest")
                    .font(.body)
                    .bold()
            })
            .frame(width: UIScreen .main.bounds.width-20, height: 58, alignment: .center)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .background(Color("PrimaryColor"))
            .cornerRadius(20)
        }
        .padding(.bottom,25)
    }
    
    var toScanClueView: some View {
        VStack(alignment: .leading){
            HStack {
                VStack (alignment: .leading){
                    HStack{
                        VStack(alignment: .leading) {
                            HStack{
                                Text("10 mnt").fontWeight(.bold).font(.title).foregroundColor(.blue)
                                Text("(2.5 km)").fontWeight(.medium).font(.title3)
                            }
                            .padding(.bottom,2)
                            Text("menuju BOLA GURITA").fontWeight(.medium).font(.title3)
                        }
                        Spacer()
                    }
                    .padding(.leading,30)
                }
                Button(action: {
                    //hide route clue
                    showToScanModal = true
                    showToScanClueModal = false
                }, label: {
                    Image(systemName: "chevron.down")
                        .font(Font.system(size: 33, weight: .bold))
                })
                .foregroundColor(Color("PrimaryColor"))
                .cornerRadius(11)
                .padding(.trailing,20)
                
            }
            Divider().frame(maxWidth:UIScreen.main.bounds.width-20, maxHeight:10)
            VStack (alignment: .leading){
                Text("Petunjuk")
                    .fontWeight(.bold).font(.title2)
                    .padding(.leading,30)
                Text("Makanan Khas Jepang")
                    .font(.title3)
                    .padding(.leading,30)
                    .padding(.top,5)
                    .padding(.bottom,5)
                Text("Terbuat dari tepung dan gurita")
                    .font(.title3)
                    .padding(.leading,30)
                    .padding(.top,5)
                    .padding(.bottom,5)
                Text("Bentuknya seperti bola pingpong, biasa di sajikan bersama mayonaise dan serbuk ikan")
                    .font(.title3)
                    .padding(.leading,30)
                    .padding(.top,5)
                    .padding(.bottom,5)
                Text("Rasanya gurih dan agak manis dari mayonaise")
                    .font(.title3)
                    .padding(.leading,30)
                    .padding(.top,5)
                    .padding(.bottom,5)
            }
            .padding(.bottom,30)
            Divider().frame(maxWidth:UIScreen.main.bounds.width-20, maxHeight:10)
            HStack{
                Spacer()
                Button(action: {
                    //quest
                }, label: {
                    Text("SCAN")
                        .font(.body)
                        .bold()
                })
                .frame(width: UIScreen.main.bounds.width-20, height: 58, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .background(Color("PrimaryColor"))
                .cornerRadius(20)
                Spacer()
            }
            HStack{
                Spacer()
                Button(action: {
                    //quest
                }, label: {
                    Text("AKHIRI PERJALANAN")
                        .font(.body)
                        .bold()
                })
                .frame(width: UIScreen.main.bounds.width-20, height: 58, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .background(.red)
                .cornerRadius(20)
                Spacer()
            }
        }
        .padding(.bottom,25)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
