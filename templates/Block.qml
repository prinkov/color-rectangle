import QtQuick 2.7
import QtQuick.Controls.Material 2.0

Rectangle {
    id: one

    property var letters : ['p', 'i', 'd', 'o', 'r']
    property int iterate: 1
    property int number

    color: "transparent"

    Letter {
        let:  letters[number]
            /*{
            var t = Math.ceil(Math.random()*letters.length-1)
            letters[t]
        }*/
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
    property var oneAnim: NumberAnimation {

    }
    property var twoAnim: NumberAnimation {
    }
}
