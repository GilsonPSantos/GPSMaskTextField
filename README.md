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

Apenas isso já é o suficiente para que você possa utilizar todos os recursos de validações básicas, disponíveis no Interface Builder. Com o GPSMaskTextField você não precisa nem atribuir o delegate à sua ViewController, isso já é feito automático. 

Mas se preferir implementar o próprio delegate do UITextField, poderá fazê-lo da forma convencional que automaticamente ele torna-se prioritário na sua ViewController.

- No Interface Builder temos as seguintes configurações:

![Configurações](https://uploaddeimagens.com.br/images/002/056/639/original/Configuracoes.png)

- `Custom Mask`: Mascara a ser utilizada conforme exemplos:
```swift
1 - (##) #### - ####
2 - #### %
3 - ####### @gmail.com
```
a mascara poderá ser uma cadeia de caracteres, espaços e etc. O # é onde o texto será inserido pelo usuário.

O melhor na utilização do Custom Mask é que visando a praticidade do desenvolvedor na hora de resgatar o valor atribuido ao UITextField o GPSMaskTextField possui uma função, conforme exemplo abaixo que retorna o valor digitado pelo usuário sem a mascara, não precisando mais fazer replace para obtenção desse valor:

```swift
let valueString = textField.getTextWithoutMask()
```

- `Minimum Size`: Minimo de caracteres exigidos para o campo.
- `Maximum Size`: Máximo de caracteres exigidos para o campo.

Caso campo Custom Mask seja preenchido essas 2 configurações serão automaticamente atribuidas com o tamanho da mascara configurada.

- `Name TextField`: Nome amigável, utilizado para a opção de validação de todos os campos (tratado abaixo), na qual retorna para o campo não válido esse nome amigável, caso o desenvolvedor queira usá-lo para apresentação de mensagem.

- `Is Currency`: Um valor que determina se o campo é do tipo monetário, se sim os campos "Main Separator e Decimal Separator" deverão ser preenchidos. Por default esse valor é off (false).

- `Main Separator`: Caracter utilizado quando o campo for do tipo monetário, nas cadas dos milhares, configurado no "Is Currency".

- `Decimal Separator`: Caracter utilizado quando o campo for do tipo monetário, nas casas deciamais, configurado no "Is Currency".

Exemplo de utilização:

![Configurações](https://uploaddeimagens.com.br/images/002/068/593/original/confCurrency.png)

Saída:

```swift
"1.200,00"
"76.454.500,00"
```
- `Is Required`: Configuração que determina se o campos será obrigatório ou não para utilização na funcionalidade de validação de todos os campos, conforme explicado abaixo na opção "Validando todos os campos".

- `Next To Validate`: Se "On" habilita o campo para que, após a validação de acordo com suas configurações realizadas, ele passa o fucus para o próximo campo, se houver. Por default esse valor é "Off". Para que esse funcionalidade funcione adequadamente é preciso que os IBOutlets estenam declarados na sua Controller na mesma ordem do seu Interface Builder.

## Validando todos os campos

GPSMaskTextField possui uma classe de validação que se instanciada, usando reflection, se encarrega de todas as validações configuradas para o campo e notifica sua controller se todos os campos estão validos ou não conforme explicado na seção de "Delegates da validação dos campos".

Para utilizar os recursos de validação automática basta chamar no viewDidLoad da sua Controller a instância da classe "ValidationFields()", chamando sua função "validationAllFields()", informando qual a classe que possui os objetos do GPSMaskTextField a serem validados no primeiro parâmetro e no segundo quem implementará o delegate com as respostas "ValidationFieldsDelegate", conforme exemplo abaixo:

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
        // Todos os campos estão válidos
    }
    
    func notValidAllFields(fildesNotValid: [FieldsValidation]) {
        // Informa todos os campos que ainda não atenderam a sua validação
    }  
}
```

## Credits

GPSMaskTextField was developed by Gilson Santos (gilsonsantosti@gmail.com)
