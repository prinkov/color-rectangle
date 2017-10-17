pragma Singleton
import QtQuick 2.7

QtObject {
    property int scores: 0
    property int lifes: 3
    property bool contin: false
    property int speedConstant: 20
    property int countDestroy: 0

    property var scene
    signal die

    function newGame() {
        scores = 0
        lifes = 3
        contin = true
        speedConstant = 10
    }

    function lifeIncrease() {
        if(lifes == 0) {
            die()
            contin = false
        }
        lifes--
    }

    function speedIncrease() {
        console.log(speedConstant)
        speedConstant--
    }

    function speedDecrease() {
        speedConstant++
    }
}
