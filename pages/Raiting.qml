import QtQuick 2.7
import QtQuick.Controls 2.0

import xyz.prinkov 1.0

Rectangle {
    id: raiting

    Image {
        anchors.fill: parent
        source: "qrc:/images/background.png"
    }

    property var localRecord

    Component.onCompleted: {
        localRecord = Workspace.getRecord()
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
        anchors.margins: 40
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
        Text {
            id: scrTD
            text: "1. "+localRecord.name + "       " + localRecord.score+""
            color: localRecord.color
            font.family: mainFont.name
            font.pixelSize: 26
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lblTD.bottom
            anchors.topMargin: 5
        }

        Text {
            id: lblW
            color: "white"
            font.family: mainFont.name
            font.pixelSize: 28
            font.bold: true
            anchors.top: scrTD.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter

            text: "Worldwide"
        }
    }
}
