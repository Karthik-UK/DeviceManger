//
import Foundation
import UIKit
//class LoginVM{
//    var LoginInfo : [LoginFields] = []
//    func Login(){
//        let Details:[LoginFields] = [LoginFields(Title: "Email", textField: CustomTextField.init() ),LoginFields(Title: "Password", textField: CustomTextField.init() )]
//        LoginInfo = Details
//    }
//}

class CustomTextField: UITextField{
    //var txtEmailfield = UITextField(frame: CGRect(x: 10.0, y: 20.0, width: 300.0,height: 40.0))
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createBorder()
    }
    func createBorder(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor(red: 55/255, green: 78/255, blue: 95/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true}
//    txtEmailfield.backgroundColor = UIColor.redColor()
//    txtEmailfield.borderStyle = UITextBorderStyle.None
//    txtEmailfield.font=UIFont.systemFontOfSize(12)
//    txtEmailfield.placeholder="Email(Required)"
//    txtEmailfield.autocorrectionType=UITextAutocorrectionType.No
//    txtEmailfield.keyboardType=UIKeyboardType.Default
//    txtEmailfield.returnKeyType=UIReturnKeyType.Done
//    txtEmailfield.delegate = self
//    txtEmailfield.clearButtonMode=UITextFieldViewMode.WhileEditing
//    txtEmailfield.contentVerticalAlignment=UIControlContentVerticalAlignment.Center
    //self.view.addSubview(txtEmailfield)
    
    
    
    
    
}
