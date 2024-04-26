# Librairie InStream de Digiteka

[![en](https://img.shields.io/badge/lang-en-red.svg)](ReadMe.md)
[![fr](https://img.shields.io/badge/lang-fr-blue.svg)](ReadMe.fr.md)

# Installation

Ajouter la dépendance à votre projet avec l'une de ces solutions :

## CocoaPods

Vous pouvez utiliser [CocoaPods](https://cocoapods.org/) pour installer `InStreamSDK` en ajoutant ce code à votre fichier `Podfile` :

`pod 'InStreamSDK', '~> 1.0.1'`

## Swift Package Manager

Vous pouvez intégrer `InStreamSDK` en tant que package Swift en ajoutant l'URL suivante du repository public dans Xcode :

`git@bitbucket.org:beappers/digiteka.instream.xcframework.git`

# Utilisation

Dans la méthode `application(_:, didFinishLaunchingWithOptions:)` de votre class `ApplicationDelegate`, ajoutez le code suivant pour initialiser la librairie :

    do {
        try InStream.shared.initialize(config: DTKISConfig(apiKey: "01357940"))
    } catch {
        print("Can't init InStream with error \(error.localizedDescription)")
    }

## Logger

Il est possible de définir un logger personnalisé pour récupérer les logs de la librairie. Le logger doit implémenter le protocol `DTKISLoggerDelegate` :

    extension AppDelegate: DTKISLoggerDelegate {
        func InStreamWarn(message: String) {
            print("warn " + message)
        }
        
        func InStreamError(message: String, error: Error?) {
            print("error " + message, error as Any)
        }
    }
    
Puis passez le logger à la librairie :

    InStream.shared.setLoggerDelegate(self)
    
## Configs

### DTKISConfig
- mdtk (String) : api key
- debugMode (Boolean) : optionnel

### DTKISMainPlayerConfig
- zone (String) : permet de déterminer sur quelle zone du site la vidéo a été publiée
- src (String) : permet de définir l’ID de la vidéo à jouer
- urlreferrer (String) : permet de définir l’URL correspondant à l’article sur Desktop (URL referrer)
- gdprconsentstring (String) : permet de nous communiquer la chaîne de consentement RGPD de l’utilisateur
- tagparam (String) : permet de nous communiquer des paramètres publicitaires facultatifs
- playMode (PlayMode): .user : appuyer pour lancer, .auto : lancement automatique lorsque la vidéo est chargée, .scroll : scroll à 50% pour lancer la vidéo automatiquement

### DTKISVisiblePlayerConfig
- playerPosition (VisiblePlayerPosition) : position du visible player (TOP_START, TOP_END, BOTTOM_START, BOTTOM_END)
- widthPercent (WidthProportion) : largeur du visible player en pourcentage de la vue parent
- ratio (Ratio) : ratio du video player largeur / hauteur
- horizontalMargin (CGFloat) : margin du visible player
- verticalMargin (CGFloat) : margin du visible player

## MainPlayerView (UIKIT)

Récuperez une instance du `MainPlayerView` en appelant : 
    
    var myMainPlayerView: MainPlayerView?
    let myConfig: DTKISMainPlayerConfig = ... votre config
    
    do {
        try myMainPlayerView = InStream.shared.initMainPlayerWith(config: myConfig) 
    } catch {
        // peut renvoyer une erreur si mal initialisé
    }

Puis la mettre dans une containerview (qui peut être une UIView dans une UITableViewCell, ou juste une UIView) en appelant : 

    myMainPlayerView?.setIn(containerView: myContainerView)
    
## Si playMode = .scroll (UIKIT)

Dans votre UIViewController, avoir une instance du MainPlayerView
Puis utiliser l'extension de UIScrollView :

    extension MyViewController: UIScrollViewDelegate {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
            if let myMainPlayerView = myMainPlayerCell.myMainPlayerView {
            
                myMainPlayerView.viewDidScroll(scrollView: scrollView)
            }
        }
    }

## VisiblePlayer (UIKIT)

Dans votre UIViewController

    var visiblePlayer: VisiblePlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myConfig: DTKISVisiblePlayerConfig = ... votre config
        
        myVisiblePlayer = InStream.shared.initVisiblePlayerWith(config: myConfig, in: self.view, scrollView: scrollView)
    }
    
    
    extension MyViewController: UIScrollViewDelegate {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
            if let myMainPlayerCell = myMainPlayerCell, let myMainPlayerView = myMainPlayerCell.mainPlayerView {
            
                visiblePlayer?.viewDidScroll(mainPlayerView: myMainPlayerView)
            }
        }
    }

## MainPlayer et VisiblePlayer (SwiftUI)

Si vous voulez uniquement une instance du MainPlayer (avec playMode = .auto ou .user), vous pouvez simplement appeler
 
    InStream.shared.initMainPlayerRepresentable(config: DTKISMainPlayerConfig)
    
Cela retourne une View que vous pouvez utiliser dans une ScrollView
    

Si vous prévoyez d'utiliser d'autres fonctionnalités comme : visiblePlayer ou playMode = .scroll, 
vous devez utiliser `InStreamScrollVStack`, une ScrollView dans laquelle vous pouvez ajouter du contenu

        InStreamScrollVStack(config: mainPlayerConfig, visiblePlayerConfig: visiblePlayerConfig, data: mockData, playerInsertPosition: 10) { element in
            Text("element.id")
                .fixedSize(horizontal: false, vertical: true)
        }
        
Le champ visiblePlayerConfig peut être nil si vous ne voulez pas de visiblePlayer

## Erreurs et Logs

| Type          | Code d'erreur | Niveau   | Message                                                                                                                                    | Cause
|---------------|---------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|     
| Configuration | DTKIS_CONF_3  | Error    | InStream sdk has not yet been initialized. Please call `InStream.shared.initialize` first.                                                 | `InStream.shared.initialize` n'a pas encore été appelé        


