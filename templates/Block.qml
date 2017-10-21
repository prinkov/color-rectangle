import QtQuick 2.7
import QtQuick.Controls.Material 2.0
import QtQuick.Particles 2.0

import xyz.prinkov 1.0

Rectangle {
    property bool animation: true
    property int number: 0
    signal boomed
    property int conveyorHeight: 0

    property string col: {
        Workspace.colors[Math.ceil(Math.random()*8)]
    }

    color: "transparent"
    width: parent.width
    height: parent.width
    y:-width

    property int durationPre: {
        Math.ceil(width * Workspace.speedConstant)
    }
    property double durationPost: {
        Math.ceil(conveyorHeight * Workspace.speedConstant)
    }
    property var oneAnim: NumberAnimation {

    }
    property var twoAnim: NumberAnimation {
    }


    //todo корректировка чувствительности
    MouseArea {
        anchors.fill: parent
        onPressed: {
            console.log(Workspace.color  + " =? " + col)
            if(Workspace.color === col)
                Workspace.scoreIncrease()
            else
                Workspace.lifeDecrease()
            ex.start()
            ex.onStopped.connect(function() {
                boomed()
            })
        }
    }

   //---------
    Image {
        id: cover
        OpacityAnimator {
            id: ex
            target: cover
            duration: 400
            from: cover.opacity
            to: 0
            running: false
        }

        height: parent.height
        fillMode: Image.PreserveAspectFit
        antialiasing: true
        source: "qrc:/images/colors/"+col+".png"
    }

    function getRnd(n) {
        return Math.random() * n;
    }
}
