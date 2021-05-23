import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.15
import com.ulasdikme.speedometer 1.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    id: root
    width: 800
    height: 600
    visible: true
    title: qsTr("ControlMotorApp")

    property bool runMotor: false

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
                appcore.connectConsole()
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
        }
    }

    Frame {
        id: midFrame
        anchors.top: upFrame.bottom
        anchors.left: parent.left
        width: parent.width
        height: parent.height * 0.4

        Speedometer {
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
                color: runMotor ? "red" : "green"
                border.color: "#ff7e00"
                border.width: 10
            }
            text: runMotor ? qsTr("STOP") : qsTr("START")
            font.family: "Courier"
            font.pointSize: 20
            onClicked: function() {
                runMotor = !runMotor
            }
        }
    }

    Frame {
        id: botFrame
        anchors.top: midFrame.bottom
        anchors.left: parent.left
        width: parent.width
        height: parent.height * 0.2

        Slider{
                anchors.centerIn: parent
                id: sliderId
                from: 0;
                to: 1000;
                value: 500;
                width: 440;
                height: 15;
                background: Rectangle{
                    implicitHeight: 4
                    height: parent.height
                    gradient: Gradient{
                        orientation: Gradient.Horizontal
                        GradientStop{id: grad1; position: 0.0; color:"#cf3732"}
                        GradientStop{position: 0.25; color:"#e3d430"}
                        GradientStop{position: 0.5; color:"#29c910"}
                        GradientStop{position: 0.75; color:"#e3d430"}
                        GradientStop{position: 1.0; color:"#cf3732"}
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
    }
}
