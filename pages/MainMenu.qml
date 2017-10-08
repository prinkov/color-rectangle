import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.0

import xyz.prinkov 1.0

import "../templates"
Rectangle {
    id: mainMenu

    Component.onCompleted: {
    }

    Image {
        anchors.fill: parent
        source: "qrc:/images/background.png"
    }

    RectLabel {
        id: colorLbl
        animation: true
        text: "color"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 30

        height: 40
        color: "transparent"
    }
    RectLabel {
        id: colorLbl2

        animation: true
        text: "pick"
        anchors.top: colorLbl.bottom

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 30
        height: 40
        color: "transparent"
    }

    Button {
        id: cntBtn
        width: startBtn.width
        enabled: false
        text: "Continue"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: colorLbl2.bottom
        anchors.topMargin: 50
        Material.background: Material.Purple
        highlighted: true

    }

    Button {
        id: startBtn
        text: "new game"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: cntBtn.bottom
        anchors.topMargin: 10
        Material.background: Material.Green
        highlighted: true
        onClicked: {
            rootWindowStack.push(Qt.resolvedUrl("qrc:/pages/Scene.qml"))
        }
    }

    Button {
        id: result
        width: startBtn.width
        text: "Raiting"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: startBtn.bottom
        anchors.topMargin: 10
        Material.background: Material.Blue
        highlighted: true

    }

    Button {
        id: exit
        width: startBtn.width

        text: "Exit"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: result.bottom
        anchors.topMargin: 10
        Material.background: Material.Red
        highlighted: true
        onClicked: {
            Qt.quit()
        }
    }

    Rectangle {
        color: "transparent"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        height: 50
        width: parent.width


        Image {
            source: Workspace.mute ?  "qrc:/images/mute.png" : "qrc:/images/speaker.png"
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            height: parent.height - 10
            anchors.right: parent.right
            anchors.rightMargin: 20
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(!Workspace.mute)
                        parent.source = "qrc:/images/mute.png"
                    else
                        parent.source = "qrc:/images/speaker.png"
                    Workspace.switchMute()
                }
            }
        }
    }

}
