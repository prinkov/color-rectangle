import QtQuick 2.7
import QtQuick.Controls.Material 2.0

Rectangle {
    id: one

    property var letters : ['p', 'i', 'd', 'o', 'r']
    property int iterate: 1

    color: "transparent"

    Letter {
        let: {
            var t = Math.ceil(Math.random()*letters.length-1)
            letters[t]
        }
        animation: true
    }

    width: parent.width
    height: parent.width
    y:-width

    property int durationPre: {
        Math.ceil(one.width * 30)
    }
    property double durationPost: {
        Math.ceil(conveyor.height * 30)
    }

    NumberAnimation {
        id: startAnim
        target: one;
        property: "y";
        from: one.y;
        to: 0;
        duration: durationPre
        running: true

        onStopped: {
            var component = Qt.createComponent("Block.qml");
            var t = component.createObject(one.parent, {});
            contAnimt.start()
        }
    }
    NumberAnimation {
        id: contAnimt
        target: one
        property: "y";

        to: conveyor.height;
        duration: durationPost
        onStopped: {

        }
    }
}
