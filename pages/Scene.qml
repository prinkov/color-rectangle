import QtQuick 2.7
import "../templates"
Rectangle {
    id: scene

    Component.onCompleted: {
    }

    Image {
        anchors.fill: parent
        source: "qrc:/images/background.png"
    }

    Rectangle {
        id: panel
        height: 50
        z: 80
        width: parent.width
        color: "blue"
        opacity: 0.3



//        Image {
//            id: img
//            width: parent.width / 3
////            anchors.right: parent.right
////            anchors.rightMargin: 0
//            anchors.horizontalCenter: parent.horizontalCenter
//            source: "qrc:/images/table.png"
//            fillMode: Image.PreserveAspectFit

//            PropertyAnimation {
//                id: animation;
//                target: img;
//                property: "width";
//                to: 30;
//                duration: 500
//                running: true
//            }

//        }

    }
    Row {
        anchors.top: panel.top
        anchors.topMargin: 50
        width: parent.width
        height: parent.height - 50
        Repeater {
            model: 6
            Conveyor {
                id: yt
                number: index
    //            anchors.top: panel.top
    //            anchors.topMargin: 50
                width: parent.width / 6
                height: parent.height
    //            height: parent.height - 50
        //        anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

}
