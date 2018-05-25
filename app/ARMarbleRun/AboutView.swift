//
//  AboutView.swift
//  ARMarbleRun
//

import UIKit
import SceneKit
import ARKit

class AboutView: UIViewController {

    @IBOutlet var debugSwitch: UISwitch!

    @IBAction func didPressClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didPressGitHubLink(_ sender: Any) {
        open(url: "https://github.com/eduDorus/PAWI")
    }

    @IBAction func didPressWarehouseLink(_ sender: Any) {
        open(url: "https://3dwarehouse.sketchup.com/model/186c758680cfa2a522da50b0bf761759")
    }

    @IBAction func didChangeDebugSwitch(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "debugMode")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        debugSwitch.isOn = UserDefaults.standard.bool(forKey: "debugMode")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    private func open(url: String) {
        UIApplication.shared.open(URL(string: url)! as URL, options: [:], completionHandler: nil)
    }

}
