import QtQuick 2.7
import QtQuick.Controls 2.0
import xyz.prinkov 1.0

Item {
    id: root
    z: 100
    anchors.fill: parent
    signal closeWindow;
    MouseArea {
        anchors.fill: parent
        onClicked: {}
    }
    Rectangle {
        color: "black"
        anchors.fill: parent
        opacity: 0.6
    }

    Rectangle {
        radius: width * 0.05
        Text {
            id: txt
            font.family: mainFont.name
            font.pixelSize: 26
            width: parent.width
            color: "#1e0478"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            horizontalAlignment: Text.AlignHCenter
            text: "You win!"
        }

        Rectangle {
            id: scoresRect
            color: "transparent"
            anchors.top: txt.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            height: 50

            Text {
                id: scoresText
                font.family: mainFont.name
                font.pixelSize: 26
                color: "#1e0478"
                anchors.horizoWorkspace.colorntalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 10
                horizontalAlignment: Text.AlignHCenter
                text: "Scores: "+Workspace.scores

            }

        }

        Rectangle {
            id: nameRect
            anchors.top: scoresRect.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            height: 50
            color: "transparent"
            TextField {
                id: nameText
                horizontalAlignment: TextField.horizontalAlignment
                color: "#000000"
                background: Rectangle {
                        anchors.fill: parent
                        radius: width * 0.05
                }

                placeholderText: "nickname"

                font.family: mainFont.name
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 26
            }
        }

        Button {
            id: saveBtn
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: nameRect.bottom
            anchors.topMargin: 10
            width: 100
            height: 100
            background: Image {
                source: "qrc:/images/checked.png"
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                antialiasing: true
            }

            onClicked: {
                Workspace.saveRecord(nameText.text, Workspace.color,
                                     Workspace.scores)
                closeWindow()

            }

            onPressed: {
                saveBtn.opacity = 0.5
            }

            onReleased: {
                saveBtn.opacity = 1
            }
        }

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "#94e7ef"
        width: 0.8 * parent.width
        height: 0.6 * parent.height

    }
}
