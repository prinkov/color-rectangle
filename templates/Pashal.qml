import QtQuick 2.7
import QtQuick.Controls 2.0
import xyz.prinkov 1.0


Image {
    source: "qrc:/images/pascal.png"
    width: 190
    height: 190
    id: pashalka
    z: 100
    visible: false
    anchors.horizontalCenter: parent.horizontalCenter
    SequentialAnimation on y {
        id: yAnim
        running: false
        NumberAnimation { from: y -100; to: y + application.height/2; duration: 4300; easing.type: Easing.InOutQuad }
        NumberAnimation { from: y + application.height / 2; to: y - 200; duration: 4300; easing.type: Easing.InOutQuad }
    }

    SequentialAnimation on rotation {
        id: rotAnim
        running: false
        loops: Animation.Infinite
        NumberAnimation { from: -10; to: 10; duration: 1000; easing.type: Easing.InOutSine }
        NumberAnimation { from: 10; to: -10; duration: 1000; easing.type: Easing.InOutSine }
    }


    function start() {
        pashalka.visible = true
        yAnim.running = true
        rotAnim.running = true
    }

}
