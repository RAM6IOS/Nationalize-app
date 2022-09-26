
import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var viewModel = NationalityVM()
        @State private var name: String = "Youcef"
        @State var showsheet :Bool = false
    var body: some View {
        NavigationView{
                    VStack {
                        Text("Let's predirect what's your nationality, by just typing your name")
                        Spacer()
                        VStack{
                            TextField("Write your name.",text: $name)
                                .padding(10)
                                .frame(width: 350, height: 50)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray, lineWidth: 2)
                                    )
                                    .padding()
                                .onSubmit {
                                    viewModel.fetch(name: name)
                                }
                        }
                        Text(viewModel.nationality?.name ?? "")
                            .font(.largeTitle)
                        AsyncImage(url: URL(string: "https://countryflagsapi.com/png/\(viewModel.nationality?.country[0].countryID ?? "")"))
                            .frame(width: 300, height: 200)
                            .cornerRadius(15)
                            .shadow( radius: 5)
                            .padding()
                            .onAppear {
                                viewModel.fetch(name: name)
                            }
                            .onTapGesture {
                                showsheet.toggle()
                            }
                        Button{
                            withAnimation{
                            showsheet.toggle()
                            }
                        } label: {
                            HStack{
                            Image(systemName: "location.fill")
                            Text("location")
                            }
                                .padding()
                                .frame(width: 350, height: 50)
                                .font(.title3)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                            .sheet(isPresented: $showsheet) {
                                CountryMapView(countryName: countryName(countryCode: viewModel.nationality?.country[0].countryID ?? "") ?? "")
                                    
                            }
                        Spacer()
                    }
                    .navigationBarTitle("Nationalize")
                }
    }
    func countryName(countryCode: String) -> String? {
            let current = Locale(identifier: "en_US")
            return current.localizedString(forRegionCode: countryCode)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
