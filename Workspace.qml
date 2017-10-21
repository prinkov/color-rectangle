pragma Singleton
import QtQuick 2.7

QtObject {

    property int scores: 0
    property int lifes: 3
    property bool contin: false
    property int speedConstant: 10
    property int countDestroy: 0
    property int boomCount
    property var colors: ["black", "blue", "green", "orange", "pink", "purple", "red", "white", "yellow"]

    property variant colorCode: {"black":"#000000", "blue":"#0055a5", "green":"#69bd31",
                                 "orange":"#f27500", "pink":"#f22477", "purple":"#6f2b8e", "red":"#c51230",
                                 "white":"#ffffff", "yellow":"#fff000"}
    property string color: colors[3]
    property var scene
    signal die
    property bool mayCreate: true
    property int curLines: 0
    property int maxLines: 6


    function newGame() {
        boomCount = 0
        mayCreate = true
        scores = 0
        lifes = 3
        contin = true
        speedConstant = 8
        curLines = 0
    }

    function scoreIncrease() {
        scores++;
    }

    function lifeDecrease() {
        lifes--
        if(lifes == 0) {
            die()
            contin = false
        }
    }

    function boomIncrease() {
        boomCount++;
        if(boomCount < 20 * maxLines) {
            if(boomCount % (20 * curLines) == 0) {
                boomCount = 0
                mayCreate = false;
            }
        } else {
            if(boomCount == 120 * maxLines + 20 * maxLines && speedConstant > 3) {
                boomCount = 20 * maxLines;
                mayCreate = false;
                speedConstant--;
            }
        }
    }
}
