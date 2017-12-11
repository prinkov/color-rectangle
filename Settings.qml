pragma Singleton
import QtQuick 2.7
import QtQuick.LocalStorage 2.0
import xyz.prinkov 1.0
QtObject {
    property int screenWidth : 320
    property int screenHeight : 480
    property int recordForThisPhone: 0

    property string name: "Player"
    property bool mute: false
    property int speed: 0
    property var db:LocalStorage.openDatabaseSync("mydb", "1.0", "Database for save data for user", 1000000);

    Component.onCompleted:  {
        db.transaction( function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS Setting(option TEXT, value INTEGER)');

            tx.executeSql('CREATE TABLE IF NOT EXISTS Records(id INTEGER, name TEXT, score INTEGER, color TEXT)');
//            tx.executeSql('DROP TABLE Records');

            var rs = tx.executeSql('SELECT value FROM Setting WHERE option="mute"');
            if(rs.rows.item(0)) {
                mute = rs.rows.item(0).value
            } else {
                tx.executeSql('INSERT INTO Setting VALUES(?, ?)' , ["mute", (mute+0)]);
            }
        })
    }

    function switchMute() {
        db.transaction(
            function(tx) {
                tx.executeSql('UPDATE Setting SET value = '+(!mute+0)+' WHERE option="mute"');
                mute = !mute;
            }
        )
        if(mute)
            Workspace.playMusic.stop()
        else
            Workspace.playMusic.play()

    }

    function saveWorkspace(workspace) {
        console.log("saving progress")
    }
}
