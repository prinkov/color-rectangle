import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import "../templates"
Rectangle {
    id: mainMenu
    anchors.fill: parent    
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
        text: "pIck"
        anchors.top: colorLbl.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 30
        height: 40
        color: "transparent"
    }

    Button {
        id: startBtn
        text: "Continue"
        anchors.horizontalCenter: parent.horizontalCenter
        enabled: false
        anchors.top: colorLbl2.bottom
        anchors.topMargin: 60
    }

    Button {
        id: cntBtn
        text: "New game"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: startBtn.bottom
        anchors.topMargin: 10
        onClicked: {
            colorLbl.hide()
            colorLbl2.hide()
        }
    }

    Button {
        id: result
        text: "Raiting"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: cntBtn.bottom
        anchors.topMargin: 10
    }

    Button {
        id: exit
        text: "Exit"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: result.bottom
        anchors.topMargin: 10
        onClicked: {
            Qt.quit()
        }
    }
}
