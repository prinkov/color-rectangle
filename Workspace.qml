pragma Singleton
import QtQuick 2.7

import xyz.prinkov 1.0

import QtMultimedia 5.8

QtObject {



    property int scores: 0
    property int lifes: 5
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
        lifes = 3
        contin = true
        speedConstant = 4
        curLines = 0
    }

    function scoreIncrease() {
        scores++;
    }

    function lifeDecrease() {
        if(lifes == 1) {
            die()
            contin = false
        }
        if(lifes != 0)
            lifes--
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
            var j =0;
            for(var i = 0; i < 5; i++) {
                if(rs.rows.item(i)) {
                    if(rs.rows.item(i).score < newRecord) {
                        for(j = i; j < 4; j++) {
                            if(rs.rows.item(j)) {
                                if(rs.rows.item(j+1)) {
                                    tx.executeSql('UPDATE Records SET name="' + rs.rows.item(j).name
                                                  +'", color="' + rs.rows.item(j).color + '", score="' +
                                                  rs.rows.item(j).score + '" WHERE id=' + (j + 1));
                                    console.log(j +" write at  " + (j+1))
                                } else {
                                    tx.executeSql('INSERT INTO Records VALUES(?, ?, ?, ?)' ,
                                                  [j+1, rs.rows.item(j).name, rs.rows.item(j).score, rs.rows.item(j).color]);
                                    console.log(j +" write at (unused) " + (j+1))

                                }
                            } else {
                                break;
                            }
                        }
                        tx.executeSql('UPDATE Records SET name="' + name
                                      +'", color="' + color + '", score="' +
                                      newRecord + '" WHERE id=' + i);
                        console.log("new write at" + i)

                        return;
                    }
                } else {
                    tx.executeSql('INSERT INTO Records VALUES(?, ?, ?, ?)' ,
                                  [i, name, newRecord, color]);
                    console.log("new write at" + i)
                    return;
                }
            }
        })
    }

    function checkRecord(probNewRecord) {
        var ret = false;
         Settings.db.transaction(function(tx) {
                var rs = tx.executeSql('SELECT * FROM Records')
                 for(var i = 0; i < 5; i++) {
                if(!rs.rows.item(i)) {
                     ret = true
                    break;
                }
                else if(rs.rows.item(i).score < probNewRecord) {
                    ret = true
                    break
                }
            }
         })
        console.log("Wokspace.qml:96check record "
                        + probNewRecord + ", return value: " + + ret)
        return ret
    }

    function getRecord(n) {
        var rs;
        Settings.db.transaction( function(tx) {
            rs = tx.executeSql('SELECT * FROM Records');
        })
        return rs.rows.item(n)
    }

    function getCountRecord() {
        var rs;
        Settings.db.transaction( function(tx) {
            rs = tx.executeSql('SELECT * FROM Records');
        })
        return rs.rows.length

    }


// здесь должна быть главная тема
//    property var playMusic: MediaPlayer {
//          source: "qrc:/music/MainTheme.mp3"
//          autoPlay: !Settings.mute
//      }

}
