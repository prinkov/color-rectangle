import QtQuick 2.7
import QtQuick.Controls 2.0

import xyz.prinkov 1.0

Rectangle {
    property variant localRecord: []
    id: raiting

    Image {
        anchors.fill: parent
        source: "qrc:/images/background.png"
    }

    Component.onCompleted: {
        localRecord[0] = Workspace.getRecord(0)
    }

    Button {
        id: back
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        background: Image {
            fillMode: Image.PreserveAspectFit
            width: 60
            antialiasing: true
            source: "qrc:/images/return.png"
        }
        onClicked: {
            rootWindowStack.replace(Qt.resolvedUrl("qrc:/pages/MainMenu.qml"))
        }
    }

    Rectangle {
        color: "transparent"
        anchors.top: back.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        anchors.bottomMargin: 150
        anchors.topMargin: 20

        Rectangle {
            anchors.fill: parent
            color: "#607D8B"
            opacity: 0.7
            radius: width * 0.05
        }

        Text {
            id: lblTD
            color: "white"
            font.family: mainFont.name
            font.pixelSize: 28
            font.bold: true
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter

            text: "On  this  device"
        }

//        Column {
//            anchors.topMargin: 5
//            anchors.top: lblTD.bottom
//            Repeater {
//                model: 5
//                Text {
//                    id: scrTD
//                    text: "1. "+localRecord[0].name + "       " + localRecord[0].score + ""
//                    color: localRecord[0].color
//                    font.family: mainFont.name
//                    font.pixelSize: 26
//                    anchors.horizontalCenter: parent.horizontalCenter

//                }
//            }
//        }
    }
}
