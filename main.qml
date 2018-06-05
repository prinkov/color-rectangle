import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

//import com.dreamdev.QtAdMobBanner 1.0
//import com.dreamdev.QtAdMobInterstitial 1.0
import QtQuick.Window 2.2
import "./js/Kernel.js" as Kernel

import xyz.prinkov 1.0

Window {
    id: application
    visible: true

    width: Settings.screenWidth
    height: Settings.screenHeight
    title: "Rect Color"

    property var kernel: Kernel

    Component.onCompleted: {

        kernel.init(Workspace)
        Workspace.onDie.connect( function() {
            if(Workspace.checkRecord(Workspace.scores)) {

                var windowComponent = Qt.createComponent("qrc:/templates/InputWindow.qml");
                var window = windowComponent.createObject(Workspace.scene);
                window.onCloseWindow.connect(function(){
                    window.destroy();
                    rootWindowStack.replace(Qt.resolvedUrl("qrc:/pages/MainMenu.qml"))

                })
            } else {
                var windowComponent = Qt.createComponent("qrc:/templates/RestartWindow.qml");
                var window = windowComponent.createObject(Workspace.scene);
                window.onCloseWindow.connect(function(){
                    window.destroy();
                })
            }
        })
    }

    FontLoader {
        id: mainFont
        source: "qrc:/fonts/ARCADECLASSIC.TTF"
    }

    FontLoader {
        id: mainFontRus
        source: "qrc:/fonts/ARCADERUS.ttf"
    }

    StackView {
        id: rootWindowStack
//        width: parent.width
//        height: parent.height - 50
//        x: 0
//        y: 0
        anchors.fill: parent
        initialItem: Qt.resolvedUrl("qrc:/pages/MainMenu.qml")
        pushEnter:  Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }

        replaceExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }

        replaceEnter:  Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }

        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }

        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }
       popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }
    }


    Component.onDestruction: {
    }

    onFocusObjectChanged: {
    }

    Rectangle {
        id: footer
        color: "transparent"
        height: 50
        z: 10
        width: parent.width

        x: 0
        y: parent.height - 50
    }

//    AdMobBanner {
//            id: banner
//            x: footer.x
//            y: footer.y - 50
////            y: footer.y / 2 + footer.y + footer.height - 5
//            Component.onCompleted: {
//                console.log("footer y " + footer.y)
//                console.log("banner y " + banner.y)
//                console.log("height " + application.height)
//                banner.unitId = "ca-app-pub-9405260411782977/4775980193"
//                banner.size = AdMobBanner.SmartBanner
//                banner.visible = true
//            }
//     }
}
