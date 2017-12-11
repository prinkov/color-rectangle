import QtQuick 2.7

import xyz.prinkov 1.0

Item {
    id: root
    z: 100
    anchors.fill: parent
    signal selected;
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
            color: "#1e0478"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            text: "Select your color"
        }

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            spacing: 15
            Repeater {
                model: 3
                id: rowRep
                Row {
                    spacing: 20
                    Repeater {
                        property int rowIndex: index
                        model: 3
                        id: colRep
                        Block {
                            animation: true
                            height: 40
                            width: 40

                            col: Workspace.colors[colRep.rowIndex * 3 + index]
                            onBoomed: {
                                Workspace.color = col
                                root.selected()
                                root.destroy()
                            }
                        }
                    }
                }
            }
        }

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "#94e7ef"
        width: 0.8 * parent.width
        height: 0.6 * parent.height

    }
}
