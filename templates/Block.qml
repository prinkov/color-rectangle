import QtQuick 2.7
import QtQuick.Controls.Material 2.0
import QtQuick.Particles 2.0

import xyz.prinkov 1.0

Rectangle {
    property bool animation: false

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

   //---------
    Image {
        id: cover

        property int boomSpeed: 400

        OpacityAnimator {
            id: optAnim
            target: cover;
            from: cover.opacity;
            to: 0;
            duration: cover.boomSpeed
            running: false
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
                console.log(Workspace.color  + " =? " + col)
                if(Workspace.color === col)
                    Workspace.scores++
                else
                    Workspace.lifeIncrease()
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
    }

    function getRnd(n) {
        return Math.random() * n;
    }

    function getColor() {
       return Workspace.colorCode[col]
    }

}
