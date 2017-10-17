var workspace
var curLines
var maxLines = 7
function init(workspace_) {
    workspace = workspace_
}

function createConv() {
    if(curLines >= maxLines)
        return;
    var convComponent = Qt.createComponent("qrc:/templates/Conveyor.qml");
    var conv = convComponent.createObject(workspace.scene.rowLines);
    conv.width =  workspace.scene.width / maxLines
    conv.height = workspace.scene.height
    createBlock(conv)
    curLines++
}

function createBlock(conv) {
    var component = Qt.createComponent("qrc:/templates/Block.qml");
    var t = component.createObject(conv);
    t.oneAnim.target = t;
    t.oneAnim.property = "y";
    t.oneAnim.from = t.y;
    t.conveyorHeight = conv.height
    t.oneAnim.to = 0;
    t.oneAnim.duration = t.durationPre;

    t.twoAnim.target = t;
    t.twoAnim.property = "y";
    t.twoAnim.to =  conv.height;
    t.twoAnim.duration = t.durationPost
    t.oneAnim.start()
    t.oneAnim.stopped.connect(function() {
        createBlock(conv)
        t.twoAnim.start()
    })
    t.twoAnim.stopped.connect(function() {
        if(t.col === workspace.scene.color) {
            workspace.lifeIncrease()
        }
        t.destroy()
    })

    t.onBoomed.connect(function() {
         t.destroy()
    })

//    t.onDestroy.connect (function() {
//        workspace.countDestroy++
//        if(workspace.countDestroy / curLines == 50)
//            workspace.speedIncrease()
//    })

}
