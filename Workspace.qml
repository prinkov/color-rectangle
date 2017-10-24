pragma Singleton
import QtQuick 2.7

import xyz.prinkov 1.0

QtObject {

    property int scores: 0
    property int lifes: 3
    property bool contin: false
    property int speedConstant: 4
    property int boomCount
    property var colors: ["black", "blue", "green", "orange", "pink", "purple", "red", "white", "yellow"]

    property variant colorCode: {"black":"#000000", "blue":"#0055a5", "green":"#69bd31",
                                 "orange":"#f27500", "pink":"#f22477", "purple":"#6f2b8e", "red":"#c51230",
                                 "white":"#ffffff", "yellow":"#fff000"}
    property string color
    property var scene
    signal die
    property bool mayCreate: true
    property int curLines: 0
    property int maxLines: 6


    function newGame() {
        boomCount = 0
        mayCreate = true
        scores = 0
        lifes = 5
        contin = true
        speedConstant = 4
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
            if(boomCount == 120 * maxLines + 20 * maxLines && speedConstant > 2) {
                boomCount = 20 * maxLines;
                mayCreate = false;
                speedConstant--;
            }
        }
    }

    function saveRecord(name, color, newRecord) {
        if(!newRecord)
            return
        Settings.db.transaction( function(tx) {
            var rs = tx.executeSql('SELECT * FROM Records');
            if(rs.rows.item(0)) {
                tx.executeSql('UPDATE Records SET name="'+name+'", color="'+color+'", score="'+newRecord+'" WHERE id=1');
            } else {
                tx.executeSql('INSERT INTO Records VALUES(?, ?, ?, ?)' , [1, name, newRecord, color]);
            }
        })
    }

    function checkRecord(probNewRecord) {
        var ret;
         Settings.db.transaction(function(tx) {
            var rs = tx.executeSql('SELECT * FROM Records');
            if(!rs.rows.item(0))
                 ret = true
            else if(rs.rows.item(0).score < probNewRecord)
                ret = true
            else
                ret = false
         })
        return ret
    }

    function getRecord() {
        var rs;
        Settings.db.transaction( function(tx) {
            rs = tx.executeSql('SELECT * FROM Records');
        })
        return rs.rows.item(0)
    }

}
