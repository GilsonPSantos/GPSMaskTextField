# GPSMaskTextField

GPSMaskTextField is a framework for UITextField that helps the development of forms without the developer worrying about the basics of validations that a field needs.

This framework has a validation system using reflection and in a simple and practical way it is possible to validate all text fields in a ViewController using very little code.

## Requirements

- iOS 10.0+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
- Xcode 10.1+
- Swift 4.2+


## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate GPSMaskTextField into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'GPSMaskTextField', '~> 1.0.0'
```

## Usage

- First you must create a UITextField in Interface Builder.

![criando um UITextField](https://uploaddeimagens.com.br/images/002/056/264/original/criacaoTextField.png)

- Second just assign the custom class GPSMaskTextField to your UITextField

![atribuindo a classe customizada](https://uploaddeimagens.com.br/images/002/056/282/original/AtribuindoClasseCustomizada.png)

- Third import the GPSMaskTextField and create the IBOutlet:

```swift
import GPSMaskTextField
```
![criando o Outlet](https://uploaddeimagens.com.br/images/002/056/625/original/CriandoOutlet.png)

```swift
@IBOutlet weak var textField: GPSMaskTextField!
```

This alone is enough for you to use all the basic validation features available in Interface Builder. With the GPSMaskTextField you do not even have to assign the delegate to your ViewController, this is already done automatically. 

But if you prefer to implement the UITextField delegate itself, you can do so in the conventional way that automatically becomes a priority in your ViewController.

- In the Interface Builder we have the following configurations:

![Configurações](https://uploaddeimagens.com.br/images/002/056/639/original/Configuracoes.png)

- `Custom Mask`: Mascara to be used as examples:
```swift
1 - (##) #### - ####
2 - #### %
3 - ####### @gmail.com
```
The mask can be a string of characters, spaces, and so on. The # is where the text will be entered by the user.

The best thing about using Custom Mask is that for the convenience of the developer to redeem the value assigned to the UITextField, the GPSMaskTextField has a function, according to the example below, that returns the value entered by the user without the mask, no longer having to do replace for obtaining of this value:

```swift
let valueString = textField.getTextWithoutMask()
```

- `Minimum Size`: Minimum of characters required for the field.
- `Maximum Size`: Maximum characters required for the field.

If Custom Mask field is filled in these 2 settings will be automatically assigned with the mask size set.

- `Name TextField`: Friendly name, used for the validation option of all the fields (treated below), in which returns to the invalid field this friendly name, in case the developer wants to use it for message presentation.

- `Is Currency`: A value that determines if the field is of the monetary type, if yes the fields "Main Separator and Decimal Separator" should be filled in. By default this value is off (false).

- `Main Separator`: Character used when the field is of the monetary type, in the thousands, in the "Is Currency".

- `Decimal Separator`: Character used when the field is of the monetary type, in the decimal houses, configured in the "Is Currency".

Example of use:

![Configurações](https://uploaddeimagens.com.br/images/002/068/593/original/confCurrency.png)

Output:

```swift
"1.200,00"
"76.454.500,00"
```
- `Is Required`: Configuration that determines whether the fields will be mandatory or not for use in the validation functionality of all fields, as explained below in the "Validating all fields" option.

- `Next To Validate`: If "On" enables the field so that, after validation according to its settings made, it passes the fucus to the next field, if any. By default this value is "Off". For this functionality to work properly IBOutlets must be declared in their Controller in the same order as their Interface Builder.

## Validating all fields

GPSMaskTextField has a validation class that if instantiated, using reflection, takes care of all the validations configured for the field and notifies its controller if all the fields are valid or not as explained in the section "Delegates of field validation".

To use the automatic validation features, simply invoke the instance of the "ValidationFields ()" class in the viewDidLoad, calling its function "validationAllFields ()", informing which class has the GPSMaskTextField objects to validate in the first parameter and in the second who will implement the delegate with the answers "ValidationFieldsDelegate", according to example below:

The automatic validation only resets the fields that have "Is Required" enabled "On". Fields that have this option "Off" will have their masks applied normally but are not contemplated by this extra validation.

```swift
import UIKit
import GPSMaskTextField

class ViewController: UIViewController {
    
    @IBOutlet weak var textField1: GPSMaskTextField!
    @IBOutlet weak var textField2: GPSMaskTextField!
    @IBOutlet weak var textField3: GPSMaskTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ValidationFields().validationAllFields(for: self, delegate: self)
    }
}
extension ViewController : ValidationFieldsDelegate {
    func allFieldsValid() {
        // All fields are valid
    }
    
    func notValidAllFields(fildesNotValid: [FieldsValidation]) {
        // Reports all fields that have not yet met your validation
    }  
}
```
The function parameter "notValidAllFields (fildesNotValid: [FieldsValidation])" is an array of a struct returning information and the object itself GPSMaskTextField:

```swift
public struct FieldsValidation {
    var validIsRequired = false // If the field is required
    var name = "" // Friendly name configured in Interface Builder
    var errorValidation: ErrorValidateMask = .none // Enum with type of error in validation
    var textField = GPSMaskTextField() // TextField field object
}
```
## Field Validation Delegates

To use the automatic validation feature provided by the "ValidationFields" class, your Controller must implement the "ValidationFieldsDelegate" and optionally you can implement the "ValidationActionDelegate" to specifically capture the keyboard display and hiding:

```swift
// Required to capture validation events
 public protocol ValidationFieldsDelegate: NSObjectProtocol {
    func allFieldsValid()
    func notValidAllFields(fildesNotValid: [FieldsValidation])
}

// Optional for capturing keyboard display or hiding
@objc public protocol ValidationActionDelegate: NSObjectProtocol {
    @objc optional func showKeyboard(notification: Notification)
    @objc optional func hideKeyboard(notification: Notification)
    
}
```

## Thanks

First of all, thank God, my family for the support and especially the understanding and for my friends who helped me and supported me from the beginning, especially my friends Tomaz Correa, Vitor Maura, Millfford Bradshaw. Thank you all.

## Credits

GPSMaskTextField was developed by Gilson Santos (gilsonsantosti@gmail.com)
