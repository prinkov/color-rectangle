import QtQuick 2.7

Rectangle {
    id: rectLabel
    property string text: ""
    property bool animation: false

    NumberAnimation on opacity {
        id: anim
        to: 0.2
        duration: 600
        running: false
    }



    Row {
        id: oner
        anchors.top: parent.top
        anchors.topMargin: 0
        width: parent.width
        height: parent.height
        spacing: 10

        anchors.left: parent.left
        anchors.leftMargin: 0

        Component.onCompleted: function() {
            var component = Qt.createComponent("Letter.qml");

            for(var i = 0; i < text.length; i++)
            component.createObject(oner, {"let": text.charAt(i), "animation": animation})
        }

    }

    function getRnd(n) {
        return Math.random() * n;
    }

    function hide() {
        anim.start()

    }

}
