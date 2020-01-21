//
//  LeagueTableViewController.swift
//  Project
//
//  Created by formando on 21/11/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import UIKit
import CoreLocation

class LeagueTableViewController: UITableViewController, CLLocationManagerDelegate {

    // MARK: - VAR
    
    let locationManager: CLLocationManager = CLLocationManager();
    let geoCoder = CLGeocoder()
    
    var cityFounded: String? = nil
    
    @IBOutlet var leagueTableView: UITableView!
    @IBOutlet weak var searchOutlet: UITextField!
    
    var arrayLeagues: [League] = [];
    var association: Association = Association()
    let identifier = "LeagueIdentifier";
    var idToSend: Int = 0;
    var modalityReceived: String = "";
    
    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocation();
        
        leagueTableView.delegate = self
        locationManager.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - GPS
    
    @IBAction func stateGPS(_ sender: Any) {
        if(CLLocationManager.authorizationStatus() == .denied ||
            CLLocationManager.authorizationStatus() == .notDetermined ) {
            getLocation();
        } else {
           if let url = URL(string: UIApplication.openSettingsURLString) {
               UIApplication.shared.openURL(url)
           }
       }
    }
    
    private func getLocation () {
        locationManager.requestAlwaysAuthorization();
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
            locationManager.startUpdatingLocation();
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        // print(location.coordinate.latitude)
        // print(location.coordinate.longitude)
        let loc = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

        geoCoder.reverseGeocodeLocation(loc, completionHandler: { (placemarks, _) -> Void in
            let placemark = placemarks?.last!
            let city = placemark?.locality
            self.cityFounded = city!

            if self.cityFounded != nil {
                self.searchOutlet.text = city!
                self.getAssociation(association: city!)
            }
        })
        locationManager.stopUpdatingLocation()
    }

    // MARK: - TABLE VIEW DATA SOURCE
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLeagues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! LeagueTableViewCell;
        cell.labelOutlet.text = arrayLeagues[indexPath.row].name;
        return cell;
    }
    
    // MARK: - ACTIONS
    
    @IBAction func onClickSearchButton(_ sender: Any) {
        view.endEditing(true)
        self.getAssociation(association: searchOutlet.text!)
    }
    
    // MARK: - NAVIGATION
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idToSend = arrayLeagues[indexPath.row].id;
        performSegue(withIdentifier: "goToClassification", sender: idToSend);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as? ClassificationTableViewController;
        info?.idLeagueReceived = self.idToSend;
    }
    
    // MARK: - GET ASSOCIATION
    
    func getAssociation(association: String) {
        let associationReplaced = association.replacingOccurrences(of: " ", with: "")
        guard let url = URL(string: "http://178.62.253.177/associacao/"+associationReplaced) else { print("URL Error"); return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
              error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                guard let decode = jsonResponse as? [[String: Any]] else { print("Decode Error"); return }
                // print(decode)
                
                if (decode.isEmpty) { return }
                
                self.association = Association(
                    id: decode[0]["id"] as! Int,
                    name: decode[0]["nome"] as! String)
                
                DispatchQueue.main.async{
                    self.getLeagues()
                }
                print("Decode Done");
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    // MARK: - GET LEAGUES
    	
    func getLeagues() {
        guard let url = URL(string: "http://178.62.253.177/divisoes/"+String(self.association.id)+"/"+self.modalityReceived) else {return}
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { (data, responligasse, error) in
            guard let dataResponse = data,
              error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                guard let decode = jsonResponse as? [[String: Any]] else { print("Decode Error"); return }
                // print(decode)

                self.arrayLeagues = []
                for item in decode {
                    self.arrayLeagues.append(League(
                        id: item["id"] as! Int,
                        name: item["nome"] as! String))
                }
                
                DispatchQueue.main.async{
                    self.leagueTableView.reloadData()
                }
                print("Decode Done");
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}
