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
                text: ":(You lose):"
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
                    color: Workspace.color; //"#1e0478"
                    anchors.horizontalCenter: parent.horizontalCenter
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
            }

            Button {
                id: restartBtn
                anchors.right: parent.right
                anchors.rightMargin: 40
                anchors.top: nameRect.bottom
                anchors.topMargin: 10
                width: 70
                height: 70
                background: Image {
                    source: "qrc:/images/reload.png"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    antialiasing: true
                }

                onClicked: {
                    Workspace.newGame()
                    rootWindowStack.replace(Qt.resolvedUrl("qrc:/pages/Scene.qml"))
                }

                onPressed: {
                    restartBtn.opacity = 0.5
                }

                onReleased: {
                    restartBtn.opacity = 1
                }
            }

            Button {
                id: exitBtn
                anchors.top: nameRect.bottom
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 40
                width: 70
                height: 70
                background: Image {
                    source: "qrc:/images/stop.png"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    antialiasing: true
                }

                onClicked: {
                    rootWindowStack.replace(Qt.resolvedUrl("qrc:/pages/MainMenu.qml"))
                }

                onPressed: {
                    exitBtn.opacity = 0.5
                }

                onReleased: {
                    exitBtn.opacity = 1
                }
            }


            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "#94e7ef"
            width: 0.8 * parent.width
            height: 0.6 * parent.height
        }
    }
