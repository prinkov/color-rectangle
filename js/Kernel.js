var workspace
var curLines = 0
var maxLines = 3
function init(workspace_) {
    workspace = workspace_
}

function createConv() {
    var convComponent = Qt.createComponent("qrc:/templates/Conveyor.qml");
    for(curLines = 0; curLines < maxLines; curLines++ ) {
        var conv = convComponent.createObject(workspace.scene.rowLines);
        conv.width =  workspace.scene.width / maxLines
        conv.height = workspace.scene.height
        createBlock(conv)
    }

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
        if(t.col === workspace.color) {
            workspace.lifeIncrease()
        }
        t.destroy()
    })

    t.onBoomed.connect(function() {
         t.destroy()
    })
}
