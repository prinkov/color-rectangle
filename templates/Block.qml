import QtQuick 2.7
import QtQuick.Controls.Material 2.0
import QtQuick.Particles 2.0

Rectangle {
    id: one
    property int number
    property bool animation: true

    signal boomed

    property int conveyorHeight: 0
    property var colors: ["black", "blue", "green", "orange", "pink", "purple", "red", "white", "yellow"]

    property variant colorCode: {"black":"#000000", "blue":"#0055a5", "green":"#69bd31",
                                 "orange":"#f27500", "pink":"#f22477", "purple":"#6f2b8e", "red":"#c51230",
                                 "white":"#ffffff", "yellow":"#fff000"}

    property string col: {
        colors[Math.ceil(Math.random()*8)]
    }

    color: "transparent"
    width: parent.width
    height: parent.width
    y:-width

    property int durationPre: {
        Math.ceil(one.width * 50)
    }
    property double durationPost: {
        Math.ceil(conveyorHeight * 50)
    }
    property var oneAnim: NumberAnimation {

    }
    property var twoAnim: NumberAnimation {
    }

   //---------
    Image {
        id: cover

        property bool animation: one.animation
        property int boomSpeed: 400

        OpacityAnimator {
            id: optAnim
            target: cover;
            from: cover.opacity;
            to: 0;
            duration: cover.boomSpeed
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
                console.log(scene.color + " " + col)
                if(scene.color == col)
                    scores++
                else
                    lifeIncrease()
                optAnim.start()
                pulseEmitter.pulse(cover.boomSpeed)
                optAnim.onStopped.connect(
                    function(){
                        boomed()
                    })

            }
        }

        height: parent.height
        fillMode: Image.PreserveAspectFit
        antialiasing: true
        source: "qrc:/images/colors/"+col+".png"
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
               target: cover;
               onStopped: stop.start()
           }
        RotationAnimator {
               id: stop
               target: cover;
               onStopped: start.start()
           }

    }

    function getRnd(n) {
        return Math.random() * n;
    }

    function getColor() {
       return colorCode[col]
    }

    function getColors() {
        return colors
    }

}
