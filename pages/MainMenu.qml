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
        width: parent.width
        anchors.topMargin: 30
        height: 40
        color: "transparent"
    }

    Column {
        anchors.top: colorLbl2.bottom
        anchors.topMargin: 50
        spacing:35
        width:parent.width

        RectLabel {
            id: cntBtn
            spacing: 1
            height: 35
            width: parent.width
            text: "continue"
            anchors.horizontalCenter: parent.horizontalCenter

            onDestroyStopped: {
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    cntBtn.destroyAll()
                }
            }
        }

        RectLabel {
            id: startBtn
            spacing: 1
            height: 35
            width: parent.width
            text: "new game"


            anchors.horizontalCenter: parent.horizontalCenter

            Material.background: Material.Green

            onDestroyStopped: {
                rootWindowStack.push(Qt.resolvedUrl("qrc:/pages/Scene.qml"))
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    startBtn.destroyAll()
                }
            }
        }

        RectLabel {
            id: result
            spacing: 1
            height: 35
            width: parent.width
            text: "raiting"
            anchors.horizontalCenter: parent.horizontalCenter

            onDestroyStopped: {

            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    result.destroyAll()
                }
            }
            Material.background: Material.Blue
        }

        RectLabel {
            id: exit
            spacing: 1
            height: 35
            width: parent.width
            text: "exit"
            anchors.horizontalCenter: parent.horizontalCenter

            Material.background: Material.Red

            onDestroyStopped: {
                Qt.quit()
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    exit.destroyAll()
                }
            }
        }
    }

    Rectangle {
        color: "transparent"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        height: 50
        width: parent.width


        Image {
            source: Settings.mute ?  "qrc:/images/mute.png" : "qrc:/images/speaker.png"
            antialiasing: true
            fillMode: Image.PreserveAspectFit
            height: parent.height - 10
            anchors.right: parent.right
            anchors.rightMargin: 20
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(!Settings.mute)
                        parent.source = "qrc:/images/mute.png"
                    else
                        parent.source = "qrc:/images/speaker.png"
                    Settings.switchMute()
                }
            }
        }
    }

}
