import QtQuick 2.1
//import QtGraphicalEffects 1.15
import QtQuick.Controls 2.1


Button{
    id: root

    property color backgroundDefaultColor: "red"
    property color backgroundPressedColor: Qt.darker(backgroundDefaultColor, 1.2)
    text: qsTr("Button")
    background: {
        implicitWidth: 83
        implicitHeight: 37
        color:roor.down ? root.backgroundPressedColor : root.backgroundDefaultColor
        radius: 3
        layer.enabled = true
//            layer.effect: DropShadow{
//                transparentBoarder: true
//                color:roor.down ? root.backgroundPressedColor : root.backgroundDefaultColor
//                samples: 20
//            }
    }
}
