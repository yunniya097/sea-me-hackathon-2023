import QtQuick 2.7
import QtQuick.Controls 2.2
import "."
import QtMultimedia 5.5

import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import QtQuick.Controls 2.1
import QtQuick.VirtualKeyboard 2.1

import QtWebEngine 1.5


ApplicationWindow {
    id: window
    visible: true
    width: screen.width
    height: screen.height
    property alias gearImage: gearImage
    property string bState: "P"
    property string video_keyword: ""
    property bool showWeather: false
    property bool showWarn: false
    property bool showLight: false

    property date currentTime: new Data()
    property int hour: currentTime.getHours()
    property int minutes: currentTime.getMinutes()
    property int seconds: currentTime.getSeconds()

    readonly property color colorGlow: "#1d6d64"
    readonly property color colorWarning: "#d5232f"
    readonly property color colorMain: "#6affcd"
    readonly property color colorBright: "#ffffff"
    readonly property color colorLightGrey: "#888"
    readonly property color colorDarkGrey: "#333"

    readonly property int fontSizeExtraSmall: Qt.application.font.pixelSize * 0.8
    readonly property int fontSizeMedium: Qt.application.font.pixelSize * 1.0
    readonly property int fontSizeLarge: Qt.application.font.pixelSize * 1.3
    readonly property int fontSizeExtraLarge: Qt.application.font.pixelSize * 4


    title: qsTr("Speedometer")

    Timer {
        id:timer
        repeat: true
        interval: 1000
        running: true
        onTriggered: {
            currentTime = new Date()
            hourtext.text = hour
            minutetext.text = minutes
            secondtext.text = seconds
        }
    }



    // Background Image
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "image/carback.png" // Replace with the path to your background image
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width:window.width
        //visible: false

        states: State{
            name: "visible"
            when: inputPanel.active
            PropertyChanges{
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }

        transitions: Transition{
            from: ""
            to: "visible"
            reversible:  true
            ParallelAnimation{
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }



//    MyButton {
//        text: "X"
//        onClicked: {
//            text: "Button"
//            console.log("button cliked")
//        }
//    }

    Frame{
        id: frame
        anchors.fill: parent
        anchors.margins: 50

        Image {
            id: gearImage
            width: 450
            height: 450
            scale: 1
            anchors.verticalCenterOffset: -100
            anchors.horizontalCenterOffset: 1
            anchors.centerIn: parent
            source: "image/volk.png" // Replace with the path to your image
            visible: bState === "P"
        }

//        Image {
//            id: siriImage
//            width: 450
//            height: 450
//            scale: 1
//            anchors.verticalCenterOffset: -100
//            anchors.horizontalCenterOffset: 1
//            anchors.centerIn: parent
//            source: "image/volk.png" // Replace with the path to your image
//            visible: false
//        }


        Camera {
            id: camera
            deviceId: "/dev/video1"
        }

        VideoOutput {
            id: videoOutput
            width: screen.width + 200 // Set width of the camera output
            height: screen.height - 100
            x: -100
            y: -50
            z : 10
            source: camera
            visible: bState === "R"
        }

        WebEngineView {
            id: webWindow
            visible: false
            width: 1000
            height: 800
            anchors.horizontalCenter: parent.horizontalCenter // Center the output horizontally
            anchors.verticalCenter: parent.verticalCenter // Center the output vertically
            url: youtubeAPI.url_youtube;
        }

        WebEngineView {
            id: navigationWindow
            visible: false
            width: 1000
            height: 800
            anchors.horizontalCenter: parent.horizontalCenter // Center the output horizontally
            anchors.verticalCenter: parent.verticalCenter // Center the output vertically
            url: "http://seamenavigation.dothome.co.kr"
        }

        Image{
            id: img_circle
            source: "image/siri.png"
            width: 100
            height: 100
            x: 1450
            y: 20
            z: 10

            visible: false

            SequentialAnimation{
                running: true
                loops: Animation.Infinite
                ScaleAnimator{
                    id: scaleanim_up
                    target: img_circle
                    from: 0.2
                    to: 1
                    duration: 300
                }
                ScaleAnimator{
                    id: scaleanim_down
                    target: img_circle
                    from: 1
                    to: 0.2
                    duration: 300
                }
            }
        }

        Button{
            id: youtuberecognize
            text: qsTr("Rec")

            width: 30
            height: 37
            x: 1450
            y: 20
            visible: false

            onClicked:{
                ybuttonClickedProcess()
                img_circle.visible = false

    //            webWindow.visible = false
    //            navigationWindow.visible = false
    //            searchbox.visible = false
            }
            function ybuttonClickedProcess(){
                stt.executeSTT();
                video_keyword = stt.searchkey;
                console.log(video_keyword)
                youtubeAPI.requestVideo(video_keyword);
                webWindow.visible = true
                img_circle.visible = false
            }
        }

        Button{
            id: closescreen
            text: "X"
            width: 30
            height: 30
            visible: false

            onClicked:{
                webWindow.visible = false
                navigationWindow.visible = false
                searchbox.visible = false
                youtuberecognize.visible = false
                closescreen.visible = false
                siriImage.visible = true
            }
        }


        ColumnLayout {
            id: mainRowLayout
            anchors.fill: parent
            anchors.margins: 24
            spacing: 36
            RowLayout {
                height: parent.height - 300
                width: parent.width
                spacing: 30

                Container {
                    id: leftTabBar

                    currentIndex: 1

                    Layout.fillWidth: false
                    Layout.fillHeight: false

                    ButtonGroup {
                        buttons: columnLayout.children
                    }

                    contentItem: ColumnLayout {
                        id: columnLayout
                        spacing: 3

                        Repeater {
                            model: leftTabBar.contentModel
                        }
                    }

                    FeatureButton {
                        id: navigationFeatureButton
                        text: qsTr("Navigation")
                        Layout.fillHeight: true
                        onClicked:{
                            navigationWindow.visible = true
                            closescreen.visible = true
                        }

                    }

                    FeatureButton {
                        text: qsTr("Youtube")
                        checked: true
                        Layout.fillHeight: true
                        onClicked:{
                            searchbox.visible = true
                            closescreen.visible = true
                            youtuberecognize.visible = true
                            siriImage.visible = false
                            img_circle.visible = true
                        }
                    }

                    FeatureButton {
                        id: youtube
                        text: qsTr("Message")
                        Layout.fillHeight: true
                        onClicked:{
//                            stt.executeSTT();
                        }

                    }

                    FeatureButton {
                        text: qsTr("Search")
                        Layout.fillHeight: true

                    }

                    FeatureButton {
                        text: qsTr("Settings")
                        Layout.fillHeight: true
                    }
                }
//                Item{
//                    x: navigationFeatureButton.x
//                    y: navigationFeatureButton.y + 75
//                    ColumnLayout{
//                        spacing: 70

//                        Image {
//                            width:30
//                            height:30
//                            id: nagivationIcon
//                            source: "image/navigation.png"
//                        }
//                        Image {
//                            id: youtubeIcon
//                            source: "image/music.png"
//                        }
//                        Image {
//                            id: messageIcon
//                            source: "image/message.png"
//                        }
//                        Image {
//                            id: commandIcon
//                            source: "image/command.png"
//                        }
//                        Image {
//                            id: settingsIcon
//                            source: "image/settings.png"
//                        }
//                    }
//                }


                Rectangle {
                    color: white
                    implicitWidth: 1
                    Layout.fillHeight: true
                }

                ColumnLayout {

                    Layout.preferredWidth: 200
                    Layout.fillWidth:true
                    Layout.fillHeight: true
                    anchors.horizontalCenterOffset: -100

                    RowLayout {
                        id: timeLabel
                        spacing: 10

                        Text{
                            id:hourtext
                            font.pixelSize: 50
                            font.italic: true
                            font.bold: true
                            text: "00"
                            color: 'white'
                        }
                        Text{
                            id:minutetext
                            font.pixelSize: 50
                            font.italic: true
                            font.bold: true
                            text: "00"
                            color: 'white'

                        }
                        Text{
                            id:secondtext
                            font.pixelSize: 50
                            font.italic: true
                            font.bold: true
                            text: "00"
                            color: 'white'
                        }
                    }
                    Label {
                        text: qsTr("2023/07/14")
                        color: colorLightGrey
                        font.pixelSize: fontSizeMedium

                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: 2
                        Layout.bottomMargin: 10
                    }
                }

                Rectangle {
                    color: white
                    implicitWidth: 1
                    Layout.fillHeight: true
                }

                Item{
                    id: searchbox
                    visible: false
                    TextField {
                        id:textfield
                        width: 800
                        height:40
                        x: 500
                        y: 0

                        placeholderText: qsTr("Enter")
                        font.pointSize: 20
                        color: "black"
                            Rectangle {
                                anchors.fill: parent
                                border.color: "white"
                                color: "transparent"
                            }
                            Rectangle {
                                x: searchbox.x + 100
                                width: 700
                                height: 40
                                color: "white"
                            }
                    }

                    Button{
                        x: textfield.x + textfield.width + 10
                        y: textfield.y
                        text: "Search"
                        onClicked: {
                            buttonClickedProcess()

                        }

                        function buttonClickedProcess(){
                            video_keyword = textfield.text
                            youtubeAPI.requestVideo(video_keyword);
                            webWindow.visible = true
                        }
                    }

                }
            }
//           /* Image {
//                id: warnIcon
//                width: 864
//                height: 80
//                anchors.verticalCenterOffset: -506
//                anchors.horizontalCenterOffset: 0
//                anchors.centerIn: parent
//                source: "image/warning.png"
//                visible: showWarn
//            }
//            Timer {
//                id: blinkTimer
//                interval: 500 // Blink every 500ms
//                running: false // Don't start running automatically
//                repeat: true
//                onTriggered: {
//                    warnIcon.visible = !warnIcon.visible // Toggle visibility
//                }
//            }
//            Image {
//                id: lightIcon
//                width: 80
//                height: 80
//                anchors.verticalCenterOffset: -506
//                anchors.horizontalCenterOffset: -548
//                anchors.centerIn: parent
//                source: "image/star.png"
//                visible: showLight*/
//            }

            Row{
                anchors.verticalCenterOffset: 450
                anchors.horizontalCenterOffset: 0
                anchors.centerIn: parent
                spacing: 10
                Text {
                    id: pText
                    font.pixelSize: 130
                    font.italic: true
                    font.bold: true
                    text: "P"
                    color: 'red'
                }

                Text {
                    id: rText
                    font.pixelSize: 130
                    font.italic: true
                    font.bold: true
                    text: "R"
                    color: 'white'
                }

                Text {
                    id: nText
                    font.pixelSize: 130
                    font.italic: true
                    font.bold: true
                    text: "N"
                    color: 'white'
                }

                Text {
                    id: dText
                    font.pixelSize: 130
                    font.italic: true
                    font.bold: true
                    text: "D"
                    color: 'white'
                }

                Connections {
                    target: buttonsReceiver
                    onButtonsValueChanged: {
                        var buttonValue = buttonsReceiver.buttonsValue;

                        if (buttonValue === "P" || buttonValue === "R" || buttonValue === "N" || buttonValue === "D") {
                            bState = buttonValue;
                            pText.color = bState === "P" ? 'red' : 'white';
                            rText.color = bState === "R" ? 'red' : 'white';
                            nText.color = bState === "N" ? 'red' : 'white';
                            dText.color = bState === "D" ? 'red' : 'white';

                            gearImage.visible = bState === "P";
                            videoOutput.visible = bState === "R";
                        }
                        else if(buttonValue === "Weather"){
                            showWeather = !showWeather;
                            weatherAPI.requestWeather("Seoul");
                        }
                        else if(buttonValue === "Warn"){
                            if (showWarn) {
                                blinkTimer.stop(); // Stop blinking
                                warnIcon.visible = false; // Ensure the icon is hidden
                            } else {
                                blinkTimer.start(); // Start blinking
                            }
                            showWarn = !showWarn;
                        }
                        else if(buttonValue === "Light"){
                            showLight = !showLight;
                        }
                    }
                }
                Label{
                    Text {
                        x : pText.x - 500
                        y : pText.y
                        id: speed
                        font.pixelSize: 80
                        font.italic: true
                        text: "speed "
                        color: 'white'
                    }
                    Text {
                        id: speedText
                        x: speed.x + speed.width
                        y: speed.y - 20
                        font.pixelSize: 130
                        font.italic: true
                        font.bold: true
                        text: "0"
                        color: 'white'
                    }
                    Connections {
                        target: speedReceiver
                        onSpeedValueChanged: {
                            var speedValue = speedReceiver.speedValue;
                            speedText.text = speedValue;
                        }
                    }
                }

                Label{
                    Text {
                        x : dText.x + 400
                        y : dText.y
                        id: rpm
                        font.pixelSize: 80
                        font.italic: true
                        text: "rpm "
                        color: 'white'
                    }
                    Text {
                        id: rpmText
                        x: rpm.x + rpm.width
                        y: rpm.y - 20
                        font.pixelSize: 130
                        font.italic: true
                        font.bold: true
                        text: "0"
                        color: 'white'
                    }
                    Connections {
                        target: rpmReceiver
                        onRpmValueChanged: {
                            var rpmValue = rpmReceiver.rpmValue;
                            rpmText.text = rpmValue;
                        }
                    }
                }
            }
        }
    }

    Image {
        id: weatherIcon
        width: 166
        height: 166
        anchors.verticalCenterOffset: -400
        anchors.horizontalCenterOffset: -650
        anchors.centerIn: parent
        source: weatherAPI.weatherIcon
        visible: showWeather
    }

    Text {
        id: temperature
        font.pixelSize: 40
        font.bold: true
        font.italic: true
        color: 'white'
        anchors.horizontalCenter: weatherIcon.horizontalCenter
        anchors.top: weatherIcon.bottom
        anchors.topMargin: -40
        text: weatherAPI.temperature + "°C"
        anchors.horizontalCenterOffset: 1
        visible: showWeather
    }


}
