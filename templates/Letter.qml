import QtQuick 2.7
import QtQuick.Particles 2.0

Image {
    id: letter
    property string let: "c"
    property bool animation: true
    property int boomSpeed: 400
    rotation: animation ? getRnd(-30) : 0
    property int fromRotation: rotation
    property int toRotation: getRnd(30)


    OpacityAnimator {
        id: optAnim
        target: letter;
        from: letter.opacity;
        to: 0;
        duration: boomSpeed
        running: false
      }

    SequentialAnimation on width {
        id: moving
        running: animation
        loops: Animation.Infinite
        NumberAnimation { from: width * 1; to: width * 1.1; duration: 800; easing.type: Easing.InOutQuad }
        NumberAnimation { from: width * 1.1; to: width * 1; duration: 1000; easing.type: Easing.InOutQuad }
    }

    ParticleSystem {
        id: particles
        anchors.fill: parent
        ImageParticle {
            source: "qrc:///particleresources/star.png"
            alpha: 0
            colorVariation: 0.6
        }

        Emitter {
            id: pulseEmitter
            x: parent.width/2
            y: 2*parent.height/3
            emitRate: 1000
            lifeSpan: 2000
            enabled: false
            velocity: AngleDirection{magnitude: 24; angleVariation: 360}
            size: 24
            sizeVariation: 8

        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            boomDestroy()

        }
    }

    height: parent.height
    fillMode: Image.PreserveAspectFit
    antialiasing: true
    source: "qrc:/images/en_alpha/"+let+".png"

    opacity: !(let == " ") ? 1 : 0

    SequentialAnimation {
        id: rotating
        running: animation
        loops: Animation.Infinite
        RotationAnimator {
               id: start
               target: letter;
               duration: 600
               from: fromRotation
               to: toRotation
               onStopped: stop.start()
           }
        RotationAnimator {
               id: stop
               duration: start.duration
               from: toRotation
               to: fromRotation

               target: letter;
               onStopped: start.start()
           }
    }


    function getRnd(n) {
        return Math.random() * n;
    }

    function boomDestroy() {
        optAnim.start()
        pulseEmitter.pulse(boomSpeed)
        optAnim.stopped.connect(function(){destroy()})
    }
}
