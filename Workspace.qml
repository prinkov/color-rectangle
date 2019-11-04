pragma Singleton
import QtQuick 2.7

import xyz.prinkov 1.0

import QtMultimedia 5.8

QtObject {
    property int scores: 0
    property int lifes: 3
    property bool contin: false
    property int speedConstant: 4
    property int boomCount: 0
    property var colors: ["black", "blue", "green", "orange", "pink", "purple", "red", "white", "yellow"]
    property var optionBlocks: ["life", "life", "shield"]

    property variant colorCode: {"black":"#000000", "blue":"#0055a5", "green":"#69bd31",
                                 "orange":"#f27500", "pink":"#f22477", "purple":"#6f2b8e", "red":"#c51230",
                                 "white":"#ffffff", "yellow":"#fff000"}
    property string color: ""
    property var scene

    signal die
    property bool mayCreate: true
    property int curLines: 0
    property int maxLines: 6
    property bool isShield: false

    property bool pressContinue: false

    property Timer shieldTimer: Timer {
        interval: 6000;
        running: false;
        repeat: false
        onTriggered: {
             isShield = false
         }
     }

    function newGame() {
        boomCount = 0
        mayCreate = true
        scores = 0
        color = ""
        lifes = 3
        speedConstant = 4
        curLines = 0
        pressContinue = false
        contin = false
        Settings.db.transaction( function(tx) {
            tx.executeSql('UPDATE Progress SET value="'+ contin + '" WHERE option="contin"');
        })
    }

    function continueGame() {
        Settings.db.transaction( function(tx) {
            var rs = tx.executeSql('SELECT * FROM Progress WHERE 1');
            Workspace.contin = rs.rows.item(0).value
            Workspace.scores = rs.rows.item(1).value
            Workspace.curLines = rs.rows.item(2).value
            Workspace.color = rs.rows.item(3).value
            Workspace.lifes = rs.rows.item(4).value
            Workspace.boomCount = rs.rows.item(5).value
            Workspace.speedConstant = rs.rows.item(6).value


        })
        pressContinue = true
    }

    function scoreIncrease() {
        scores++;
    }

    function lifeDecrease() {
        if (isShield)
            return;

        if(lifes == 1) {
            die()
            contin = false
        }
        if(lifes != 0) {
            lifes--
        }
    }

    function lifeIncrease() {
        lifes++
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

    function saveRecord(name, color, newRecord) {
        if (!newRecord)
            return
        try {
            var request = new XMLHttpRequest()
            var datatype = "application/x-www-form-urlencoded; charset=UTF-8";
            request.open('GET', 'http://datahelper.online/rectcolor/saverecord?name='+name+'&color='+color+'&record='+newRecord+'&apiKey=tesla12')
            request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
            request.send();
        } catch (e) {}

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

   function saveProgress() {
       Settings.db.transaction( function(tx) {
           tx.executeSql('UPDATE Progress SET value="' + contin + '" WHERE option="contin"');
           tx.executeSql('UPDATE Progress SET value="' + scores + '" WHERE option="scores"');
           tx.executeSql('UPDATE Progress SET value="' + curLines + '" WHERE option="curLines"');
           tx.executeSql('UPDATE Progress SET value="' + color + '" WHERE option="color"');
           tx.executeSql('UPDATE Progress SET value="' + boomCount + '" WHERE option="boomCount"');
           tx.executeSql('UPDATE Progress SET value="' + lifes + '" WHERE option="lifes"');
           tx.executeSql('UPDATE Progress SET value="' + speedConstant + '" WHERE option="speedConstant"');
       })
   }

   function isMute() {
       return Settings.mute;
   }



   function shield() {
       if (isShield) {
           shieldTimer.restart()
       } else {
           isShield = true
           shieldTimer.start()
       }
   }
}
