import QtQuick 2.7
import QtQuick.Controls.Material 2.0

import "../templates"

import xyz.prinkov 1.0

Rectangle {
    id: scene
    property var rowLines: rowLinesView

    Component.onCompleted: {
        Workspace.scene = scene
        kernel.createConv()



        Workspace.onDie.connect( function(){
            rootWindowStack.replace(Qt.resolvedUrl("qrc:/pages/MainMenu.qml"))
        })
    }

    Image {
        anchors.fill: parent
        source: "qrc:/images/background.png"
    }

    Rectangle {
        id: panel
        height: 50
        width: parent.width
        color: "transparent"
        z: 80

        MouseArea {
            anchors.fill: parent
            onClicked: {
                kernel.createConv()
            }
        }

        Rectangle {
            anchors.fill: parent
            color: Material.color(Material.BlueGrey)
            opacity: 0.6
        }

        Image {
            id: pauseIcon
            anchors.left: parent.left
            anchors.leftMargin: 10
            height: parent.height - 10
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/pause.png"
            antialiasing: true

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    rootWindowStack.replace(Qt.resolvedUrl("qrc:/pages/MainMenu.qml"))
                }
            }
        }

        Text {
            text: Workspace.lifes
            font.family: mainFont.name
            anchors.right: multiplyTxt.left
            anchors.leftMargin: 0
            anchors.verticalCenter: parent.verticalCenter
            height: heartIcon.height
            color: "#94e7ef"
            font.pixelSize: heartIcon.height
        }

        Text {
            text: "x"
            id: multiplyTxt
            font.family: mainFont.name
            anchors.right: heartIcon.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            color: "#94e7ef"
            font.pixelSize: heartIcon.height / 2
        }

        Image {
            id: heartIcon
            anchors.right: parent.right
            anchors.rightMargin: 10
            height: parent.height - 10
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/heart.png"
            antialiasing: true
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height - 10
            width: 100
            color: "transparent"
            Block {
                id: blockIcon
                animation: true
                height: parent.height/2
                width: parent.height/2
                col: Workspace.color
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: Workspace.scores
                color: blockIcon.getColor()
                font.family: mainFont.name
                anchors.left: blockIcon.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: heartIcon.height
            }
        }
    }

    Row {
        id: rowLinesView
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        width:  parent.width / kernel.curLines
        height: parent.height

    }

}
