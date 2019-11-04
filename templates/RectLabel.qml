import QtQuick 2.7

Rectangle {
    id: rectLabel
    property string text: ""
    property bool animation: false
    property int spacing: 10
    property variant letters:[]

    signal destroyStopped

    color: "transparent"
    NumberAnimation on opacity {
        id: anim
        to: 0
        duration: 600
        running: false
    }

    Row {
        id: oner
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height
        spacing: rectLabel.spacing
        Component.onCompleted: function() {
            var component = Qt.createComponent("Letter.qml");

            for(var i = 0; i < text.length; i++)
                letters[i] = component.createObject(oner, {"let_": text.charAt(i), "animation": animation})
        }

    }

    function getRnd(n) {
        return Math.random() * n;
    }

    function hide() {
        anim.start()
    }


    function destroyAll() {
        var counter = 0;
        for(var i = 0; i < letters.length; i++) {
            letters[i].boomSpeed = letters[i].boomSpeed * Math.random() * 3;

            letters[i].Component.destruction.connect(function() {
                counter++;
                if(counter == letters.length)
                    destroyStopped()
            })
            letters[i].boomDestroy()
        }
    }

}
