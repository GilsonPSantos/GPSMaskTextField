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

- Primeiro você deve criar um UITextField no Interface Builder

![criando um UITextField](https://uploaddeimagens.com.br/images/002/056/264/original/criacaoTextField.png)

- Segundo basta atribuir a classe customizada GPSMaskTextField a seu UITextField

![atribuindo a classe customizada](https://uploaddeimagens.com.br/images/002/056/282/original/AtribuindoClasseCustomizada.png)

- Terceiro import o GPSMaskTextField e crie o Outlet:

```swift
import GPSMaskTextField
```
![criando o Outlet](https://uploaddeimagens.com.br/images/002/056/625/original/CriandoOutlet.png)

```swift
@IBOutlet weak var textField: GPSMaskTextField!
```

- No Interface Builder temos as seguintes configurações:

![Configurações](https://uploaddeimagens.com.br/images/002/056/639/original/Configuracoes.png)

- `Custom Mask`: Mascara a ser utilizada conforme exemplos:
```swift
1 - (##) #### - ####
2 - #### %
3 - ####### @gmail.com
```
a mascara poderá ser uma cadeia de caracteres, espaços e etc.



## Credits

GPSMaskTextField was developed by Gilson Santos (gilsonsantosti@gmail.com)
