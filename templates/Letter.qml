import QtQuick 2.7
import QtQuick.Particles 2.0

Image {
    id: letter
    property string let: "c"
    property bool animation: false
    property int boomSpeed: 400

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
            optAnim.start()
            pulseEmitter.pulse(boomSpeed)

        }
    }

    height: parent.height
    fillMode: Image.PreserveAspectFit
    antialiasing: true
    source: "qrc:/images/en_alpha/"+let+".png"
    Component.onCompleted: {
        start.duration = getRnd(200) + 400
        stop.duration = start.duration
        start.from = 0 - getRnd(20)
        start.to = getRnd(30)
        stop.from = start.to
        stop.to = start.from
        if(animation)
            start.start()
    }

    RotationAnimator {
           id: start
           target: letter;
           onStopped: stop.start()
       }
    RotationAnimator {
           id: stop
           target: letter;
           onStopped: start.start()
       }

    function getRnd(n) {
        return Math.random() * n;
    }
}
