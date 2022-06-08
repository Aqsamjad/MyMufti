//
//  BecomeMuftiDoneVC.swift
//  myMufti
//
//  Created by Qazi on 11/02/2022.
//

import UIKit

class BecomeMuftiDoneVC: UIViewController {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var becomeMuftiDoneGIF: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        becomeMuftiDoneGIF.loadGif(name: "BecomeMuftiDone")
        doneBtn.layer.cornerRadius = 8
    }
    @IBAction func doneBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationViewController:UIViewController  = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}
