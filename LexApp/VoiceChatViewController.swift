import Foundation
import AWSLex
import UIKit

class VoiceChatViewController: UIViewController, AWSLexVoiceButtonDelegate {
    
    @IBOutlet weak var voiceButton: AWSLexVoiceButton!
    @IBOutlet weak var output: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (self.voiceButton as AWSLexVoiceButton).delegate = self
    }
    
    func voiceButton(_ button: AWSLexVoiceButton, on response: AWSLexVoiceButtonResponse) {
        DispatchQueue.main.async(execute: {
            print("on text output \(response.outputText)")
            self.output.text = response.outputText
        })
    }
    
    public func voiceButton(_ button: AWSLexVoiceButton, onError error: Error) {
        print("error \(error)")
    }
    
}
