import QtQuick 2.0

Rectangle {
    id: conveyor
    property int number
    color: "transparent"

   Component.onCompleted:{
        createBlock()
   }

   function createBlock() {
       var component = Qt.createComponent("qrc:/templates/Block.qml");
       var t = component.createObject(conveyor, {});
       t.oneAnim.target = t;
       t.oneAnim.property = "y";
       t.oneAnim.from = t.y;
       t.oneAnim.to = 0;
       t.oneAnim.duration = t.durationPre;

       t.twoAnim.target = t;
       t.twoAnim.property = "y";
       t.twoAnim.to =  conveyor.height;
       t.twoAnim.duration = t.durationPost
       t.oneAnim.start()
       t.oneAnim.stopped.connect(function() {
           createBlock()
           t.twoAnim.start()
       })
       t.twoAnim.stopped.connect(function() {
            t.destroy()
       })
   }

}
