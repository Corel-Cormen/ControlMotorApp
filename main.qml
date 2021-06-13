import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.15
import com.ulasdikme.speedometer 1.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: root
    width: 800
    height: 600
    visible: true
    title: qsTr("ControlMotorApp")

    property bool runMotor: true
    property int maxPosition: 100
    property int minPosition: -100
    property int maxSpeed: 150

    Row {
        id: upFrame
        width: parent.width
        height: parent.height * 0.1
        anchors.top: parent.top
        anchors.left: parent.left

        Button {
            id: settingsButton
            width: parent.height
            height: parent.height
            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height
                color: settingsButton.down ? "#ff7e00" : "#fff000"
                border.color: "black"
                border.width: 1
                radius: 4
            }

            icon.source: "/img/img/settings.png"
            icon.color: "transparent"
            icon.width: settingsButton.width
            icon.height: settingsButton.height

            onClicked: {
                var component = Qt.createComponent("settingsWindow.qml");
                var window = component.createObject(root)
                window.show()
            }
        }

        Button {
            id: connectionButton
            width: parent.height
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: settingsButton.width
            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height
                color: connectionButton.down ? "#ff7e00" : "#fff000"
                border.color: "black"
                border.width: 1
                radius: 4
            }

            icon.source: "/img/img/connection.png"
            icon.color: "transparent"
            icon.width: settingsButton.width
            icon.height: settingsButton.height

            onClicked: {
                try {
                    appcore.connectConsole()
                } catch(error) {
                    console.log("error")
                }
            }
        }

        Button {
            id: unconnectionButton
            width: parent.height
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: connectionButton.width + settingsButton.width
            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height
                color: unconnectionButton.down ? "#ff7e00" : "#fff000"
                border.color: "black"
                border.width: 1
                radius: 4
            }

            icon.source: "/img/img/unconnection.png"
            icon.color: "transparent"
            icon.width: settingsButton.width
            icon.height: settingsButton.height

            onClicked: {
                appcore.disconnectConsole()
            }
        }
    }

    Frame {
        id: midFrame
        anchors.top: upFrame.bottom
        anchors.left: parent.left
        width: parent.width
        height: parent.height * 0.4

        Speedometer {
            id: speedometer
            objectName: "speedoMeter"
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width / 3
            height: parent.height
            startAngle: startAngle
            alignAngle: alignAngle
            lowestRange: lowestRange
            highestRange: highestRange
            speed: speed
            arcWidth: arcWidth
            outerColor: outerColor
            innerColor: innerColor
            textColor: textColor
            backgroundColor: backgroundColor
            fontSize: parent.width / 35
        }

        RoundButton {
            id: startMotorButton
            width: parent.width / 6
            height: parent.height / 3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            background: Rectangle {
                radius: startMotorButton.radius
                color: runMotor ? "#cf3732" : "#29c910"
                border.color: "#ff7e00"
                border.width: 10
            }
            text: runMotor ? qsTr("STOP") : qsTr("START")
            font.family: "Courier"
            font.pointSize: 20

            onClicked: function() {
                runMotor = !runMotor
                if(runMotor) {
                    appcore.sendCommand("RUN=1")
                    consoleText.text += "MOTOR START\n"
                }
                else {
                    appcore.sendCommand("RUN=0")
                    consoleText.text += "MOTOR STOP\n"
                }
            }
        }

        SpinBox {
            id: speedSpinBox
            anchors.top: parent.top
            anchors.right: parent.right
            editable: true
            from: 0
            to: maxSpeed
            value: 0

            Button {
                id: sendSpeedButton
                anchors.top: parent.bottom
                anchors.left: parent.left
                width: parent.width
                height: parent.height
                background: Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: parent.height
                    color: sendSpeedButton.down ? "#ffff00" : "#ff7e00"
                    radius: 4
                }
                text: qsTr("Set Speed")

                onClicked: {
                    appcore.sendCommand("SPEED=" + speedSpinBox.value.toString())
                    consoleText.text += "SPEED=" + speedSpinBox.value + "\n";
                    speedometer.speed = speedSpinBox.value
                }
            }
        }
    }

    Frame {
        id: botFrame
        anchors.top: midFrame.bottom
        anchors.left: parent.left
        width: parent.width
        height: parent.height * 0.2

        Slider {
            id: motorPositionSlider
            anchors.centerIn: parent.left
            anchors.top: parent.top
            anchors.topMargin: parent.height / 2 - height
            from: minPosition;
            to: maxPosition;
            value: 0;
            width: parent.width * 0.7;
            height: 15;
            background: Rectangle{
                implicitHeight: 4
                height: parent.height
                gradient: Gradient{
                    orientation: Gradient.Horizontal
                    GradientStop{ position: 0.0; color: "#cf3732" }
                    GradientStop{ position: 0.1; color: "#e3d430" }
                    GradientStop{ position: 0.5; color: "#29c910" }
                    GradientStop{ position: 0.9; color: "#e3d430" }
                    GradientStop{ position: 1.0; color: "#cf3732" }
                }
            }

            onValueChanged: function() {
                positionSpinBox.value = motorPositionSlider.value
            }

            Rectangle {
                id: slider0
                anchors.centerIn: parent
                width: 1
                height: parent.height * 2
                color: "#ff7e00"

                Text {
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.leftMargin: -4
                    anchors.topMargin: 5
                    text: qsTr("0")
                    color: "#ff7e00"
                    font.pointSize: 12
                }
            }
            Rectangle {
                anchors.left: parent.left
                anchors.top: slider0.top
                width: 1
                height: parent.height * 2
                color: "#ff7e00"

                Text {
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.leftMargin: -15
                    anchors.topMargin: 5
                    text: qsTr("-100")
                    color: "#ff7e00"
                    font.pointSize: 12
                }
            }
            Rectangle {
                anchors.right: parent.right
                anchors.top: slider0.top
                width: 1
                height: parent.height * 2
                color: "#ff7e00"

                Text {
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.leftMargin: -15
                    anchors.topMargin: 5
                    text: qsTr("100")
                    color: "#ff7e00"
                    font.pointSize: 12
                }
            }
        }

        SpinBox {
            id: positionSpinBox
            anchors.top: parent.top
            anchors.right: parent.right
            editable: true
            from: minPosition
            to: maxPosition
            value: 0
            onValueChanged: function() {
                motorPositionSlider.value = positionSpinBox.value
            }

            Button {
                id: sendPositinButton
                anchors.top: parent.bottom
                anchors.left: parent.left
                width: parent.width
                height: parent.height
                background: Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: parent.height
                    color: sendPositinButton.down ? "#ffff00" : "#ff7e00"
                    radius: 4
                }
                text: qsTr("Set Position")

                onClicked: {
                    appcore.sendCommand("\nPOSX=" + motorPositionSlider.value)
                    consoleText.text += "POSX=" + motorPositionSlider.value + "\n";
                }
            }
        }
    }

    Frame {
        id: consoleFrame
        anchors.top: botFrame.bottom
        anchors.left: parent.left
        width: parent.width
        height: parent.height * 0.3

        ScrollView {
            id: scrollConsole
            //ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            //ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.vertical.position: scrollPosition

            anchors.fill: parent
            background: Rectangle {
                color: "black"
            }
            FontLoader { id: machineFont; source: "/fonts/BNMachine.ttf" }
            font.family: machineFont.name
            TextArea {
                id: consoleText
                padding: 10
            }
        }
    }
}
