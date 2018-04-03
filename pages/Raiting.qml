import QtQuick 2.7
import QtQuick.Controls 2.0

import xyz.prinkov 1.0

Rectangle {

    id: raiting

    ListModel {
        id: localRecord

    }

    Component.onCompleted: {
        var count = Workspace.getCountRecord()
        console.log("Raiting.qml:17 count of records + " + count)
        for(var i = 0; i < count; i++) {
            var t = Workspace.getRecord(i)
            localRecord.append({"i": i, "name": t.name, "txtColor" : t.color, "score" : t.score})
        }
    }

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
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            text: "On  this  device"
        }

        Component{
            id: scrDelegate

            Text {
                id: scrTD
                visible: score > 0
                text: (i+1) + ". " + name + "  " + score
                color: txtColor
                font.family: mainFont.name
                font.pixelSize: 24
                y: 140
            }
        }
        Item {
            width: 200
            height: localRecord.count * 32

            anchors.top: lblTD.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            anchors.left: parent.left
            anchors.leftMargin: 15

            ListView {
                id: ratingView
                spacing: 4
                anchors.fill: parent
                model: localRecord
                delegate: scrDelegate
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
