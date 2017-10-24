import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

import "./js/Kernel.js" as Kernel

import xyz.prinkov 1.0

ApplicationWindow {
    id: application
    visible: true
    width: 320 // Settings.screenWidth
    height: 480 //Settings.screenHeight
    title: "Color Pick"

    property var kernel: Kernel

    Component.onCompleted: {
        kernel.init(Workspace)
        Workspace.onDie.connect( function(){
            if(Workspace.checkRecord(Workspace.scores)) {
                Workspace.saveRecord("Alex", Workspace.color, Workspace.scores)
            }
            rootWindowStack.replace(Qt.resolvedUrl("qrc:/pages/MainMenu.qml"))
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
}
