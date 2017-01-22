import Foundation
import AWSLex

class ChatViewController: UIViewController {

    var messages: [String]?
    
    var interactionKit: AWSLexInteractionKit?
    var sessionAttributes: [AnyHashable: Any]?
    var textModeSwitchingCompletion: AWSTaskCompletionSource<NSString>?
    
    @IBOutlet var sendMessageField: UITextField!
    @IBOutlet var sendMessageButton: UIButton!    
    @IBOutlet var chatMessages: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactionKit = AWSLexInteractionKit.init(forKey: "chatConfig")
        self.interactionKit?.interactionDelegate = self
    }
    
    @IBAction func sendMessagePressed() {
        let text = sendMessageField.text! as String
        if let textModeSwitchingCompletion = textModeSwitchingCompletion {
            textModeSwitchingCompletion.setResult(text as NSString)
            self.textModeSwitchingCompletion = nil
        }
        else {
            self.interactionKit?.text(inTextOut: text)
        }
    }

}

// MARK: Interaction Kit
extension ChatViewController: AWSLexInteractionDelegate {
    
    public func interactionKitOnRecordingEnd(_ interactionKit: AWSLexInteractionKit, audioStream: Data, contentType: String) {
        print("interactionKitOnRecordingEnd")
    }
    
    public func interactionKit(_ interactionKit: AWSLexInteractionKit, onError error: Error) {
        //do nothing for now.
        print("interactionKit:onError:")
    }
    
    public func interactionKit(_ interactionKit: AWSLexInteractionKit, switchModeInput: AWSLexSwitchModeInput, completionSource: AWSTaskCompletionSource<AWSLexSwitchModeResponse>?) {
        print("interactionKit:switchModeInput:completionSource:")
        self.sessionAttributes = switchModeInput.sessionAttributes

        print("Response = \(switchModeInput.outputText!)")
        DispatchQueue.main.async(execute: {
            let message = switchModeInput.outputText!
            self.messages?.append(message)
            self.chatMessages.text = message
        })
        
        //this can expand to take input from user.
        let switchModeResponse = AWSLexSwitchModeResponse()
        switchModeResponse.interactionMode = AWSLexInteractionMode.text
        switchModeResponse.sessionAttributes = switchModeInput.sessionAttributes
        completionSource?.setResult(switchModeResponse)
    }
    
    /*
     * Sent to delegate when the Switch mode requires a user to input a text. You should set the completion source result to the string that you get from the user. This ensures that the session attribute information is carried over from the previous request to the next one.
     */
    func interactionKitContinue(withText interactionKit: AWSLexInteractionKit, completionSource: AWSTaskCompletionSource<NSString>) {
        textModeSwitchingCompletion = completionSource
    }

}
