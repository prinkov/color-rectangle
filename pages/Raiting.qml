import QtQuick 2.7
import QtQuick.Controls 2.0

import xyz.prinkov 1.0

Rectangle {

    id: raiting
    property variant localRecord: [
     {
         "name": "ivan",
         "color": "blue",
         "score" : 250
     },
     {
         "name": "Semenov-Tyanshan",
         "color": "red",
         "score" : 100
     },
     {
         "name": "Bolvinov",
         "color": "yellow",
         "score" : 50
     },
     {
         "name": "Loxlox",
         "color": "blue",
         "score" : 25
     },

     {
         "name": "Senina",
         "color": "white",
         "score" : 1
     }
    ]
    Image {
        anchors.fill: parent
        source: "qrc:/images/background.png"
    }

    Rectangle {
        color: "transparent"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height / 2
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

        Column {
            id: raitingCol
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Repeater {
                model: localRecord.length
                Text {
                    id: scrTD
                    text: (index+1) + ". " + localRecord[index].name + " " +
                        localRecord[index].score
                    color: localRecord[index].color
                    font.family: mainFont.name
                    font.pixelSize: 24

                }
            }
        }
    }


    Button {
        id: back

        height: raiting.width / Workspace.maxLines
        width: raiting.width / Workspace.maxLines
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 20
        background: Image {
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            source: "qrc:/images/return.png"
        }
        onClicked: {
            rootWindowStack.replace(Qt.resolvedUrl("qrc:/pages/MainMenu.qml"))
        }
    }

}
