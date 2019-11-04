import QtQuick 2.7

import "../templates"

import xyz.prinkov 1.0

Rectangle {
    id: scene

    Rectangle {
        width: parent.width
        color: "transparent"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }

    property var rowLines: rowLinesView
    RectWindow {
        id: rectWindow
        Component.onCompleted: {
            if(Workspace.pressContinue) {
                rectWindow.destroy()
                continueConv()
            }
        }
        onSelected: {
            Workspace.contin = true
            createConv()
        }
    }

    Component.onDestruction: {
        if(Workspace.contin)
            Workspace.saveProgress()
    }

    Component.onCompleted: {
        Workspace.scene = scene

    }

    Image {
        anchors.fill: parent
        source: "qrc:/images/background.png"
    }

    Rectangle {
        id: panel
        height: parent.width / Workspace.maxLines
        width: parent.width
        color: "transparent"

        z: 80

        Rectangle {
            anchors.fill: parent
            color: "#607D8B"
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
            visible: !Workspace.isShield
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
            visible: !Workspace.isShield
        }

        Image {
            id: heartIcon
            anchors.right: parent.right
            anchors.rightMargin: 10
            height: parent.height - 10
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: Workspace.isShield ? "qrc:/images/colors/shield.png" : "qrc:/images/heart.png"
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
                enabled: false
            }

            Text {
                text: Workspace.scores
                color: blockIcon.col
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
        width: parent.width
        height: parent.height
    }

    property var timer: Timer {
        interval: 1500;
        running: false;
        repeat: false
        onTriggered: {
            Workspace.mayCreate = true
            if (Workspace.curLines < Workspace.maxLines)
                createConv()
        }
    }


    function continueConv() {
        for(var i = 0; i < Workspace.curLines; i++)
            kernel.continueConv(i)
    }

    function createConv() {
        var conv = kernel.createConv()
        timer.onTriggered.connect(function() {
            var t = kernel.createBlock(conv)
        })
    }
}
