import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.15
import QtQuick.Controls.Styles 1.4
import com.ulasdikme.speedometer 1.0

ApplicationWindow {
    id: root
    width: 600
    height: 300
    visible: true
    title: qsTr("Settings Port")

    property int sizePorts: appcore.getSPSizePorts()
    property variant portName: appcore.getSPName()
    property variant description: appcore.getSPDescription()
    property variant manufacturer: appcore.getSPManufacturer()
    property variant serialNumber: appcore.getSPSerialNumber()
    property variant location: appcore.getSPLocation()
    property variant vendorIdentifier: appcore.getSPVendorIdentifier()
    property variant productIdentifier: appcore.getSPProductIdentifier()

    Frame {
        id: selectPortFrame
        width: parent.width * 0.5
        height: parent.height * 0.6
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 10

        Text {
            id: text1
            anchors.top: parent.top
            anchors.left: parent.left
            text: qsTr("Select Serial Port")
            color: "white"
        }

        ComboBox {
            id: chosePortBox
            width: parent.width
            height: parent.height * 0.2
            anchors.top: text1.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.05
            anchors.rightMargin: parent.width * 0.05
            model: portName

            contentItem: Text {
                leftPadding: 10
                text: chosePortBox.displayText
                font: chosePortBox.font
                color: "#fff000"
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            Component.onCompleted: fillDataPort(chosePortBox.currentIndex)
            onActivated: fillDataPort(chosePortBox.currentIndex)

            function fillDataPort(index) {
                descriptionInfo.text = description[index]
                manufacturerInfo.text = manufacturer[index]
                serialNumberInfo.text = serialNumber[index]
                locationInfo.text = location[index]
                vendorIdentiferInfo.text = vendorIdentifier[index]
                productIdentiferInfo.text = productIdentifier[index]
            }
        }

        Text {
            id: text2
            anchors.top: chosePortBox.bottom
            anchors.left: parent.left
            anchors.topMargin: 10
            text: qsTr("Description:")
            color: "white"
        }

        Text {
            id: text3
            anchors.top: text2.bottom
            anchors.left: parent.left
            anchors.topMargin: 5
            text: qsTr("Manufacturer:")
            color: "white"
        }

        Text {
            id: text4
            anchors.top: text3.bottom
            anchors.left: parent.left
            anchors.topMargin: 5
            text: qsTr("Serial number:")
            color: "white"
        }

        Text {
            id: text5
            anchors.top: text4.bottom
            anchors.left: parent.left
            anchors.topMargin: 5
            text: qsTr("Location:")
            color: "white"
        }

        Text {
            id: text6
            anchors.top: text5.bottom
            anchors.left: parent.left
            anchors.topMargin: 5
            text: qsTr("Vendor Identifer:")
            color: "white"
        }

        Text {
            id: text7
            anchors.top: text6.bottom
            anchors.left: parent.left
            anchors.topMargin: 5
            text: qsTr("Product Identifier:")
            color: "white"
        }

        Text {
            id: descriptionInfo
            anchors.top: chosePortBox.bottom
            anchors.left: text2.right
            anchors.topMargin: 10
            anchors.leftMargin: 5
            text: qsTr("N/A")
            color: "#ff7e00"
        }

        Text {
            id: manufacturerInfo
            anchors.top: descriptionInfo.bottom
            anchors.left: text3.right
            anchors.topMargin: 5
            anchors.leftMargin: 5
            text: qsTr("N/A")
            color: "#ff7e00"
        }

        Text {
            id: serialNumberInfo
            anchors.top: manufacturerInfo.bottom
            anchors.left: text4.right
            anchors.topMargin: 5
            anchors.leftMargin: 5
            text: qsTr("N/A")
            color: "#ff7e00"
        }

        Text {
            id: locationInfo
            anchors.top: serialNumberInfo.bottom
            anchors.left: text5.right
            anchors.topMargin: 5
            anchors.leftMargin: 5
            text: qsTr("N/A")
            color: "#ff7e00"
        }

        Text {
            id: vendorIdentiferInfo
            anchors.top: locationInfo.bottom
            anchors.left: text6.right
            anchors.topMargin: 5
            anchors.leftMargin: 5
            text: qsTr("N/A")
            color: "#ff7e00"
        }

        Text {
            id: productIdentiferInfo
            anchors.top: vendorIdentiferInfo.bottom
            anchors.left: text7.right
            anchors.topMargin: 5
            anchors.leftMargin: 5
            text: qsTr("N/A")
            color: "#ff7e00"
        }
    }

    Frame {
        width: parent.width/2 - 30
        height: parent.height * 0.6
        anchors.top: parent.top
        anchors.left: selectPortFrame.right
        anchors.topMargin: 10
        anchors.leftMargin: 10

        Text {
            id: text8
            anchors.top: parent.top
            anchors.left: parent.left
            text: qsTr("Select Parameters")
            color: "white"
        }

        ComboBox {
            id: baudRateBox
            width: parent.width / 2
            height: parent.height * 0.2
            anchors.top: text8.bottom
            anchors.right: parent.right
            model: [115200, 38400, 19200, 9600]
            contentItem: Text {
                leftPadding: 10
                text: baudRateBox.displayText
                font: baudRateBox.font
                color: "#ff7e00"
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }

        ComboBox {
            id: dataBitsBox
            width: parent.width / 2
            height: parent.height * 0.2
            anchors.top: baudRateBox.bottom
            anchors.right: parent.right
            model: [8, 7, 6, 5]
            contentItem: Text {
                leftPadding: 10
                text: dataBitsBox.displayText
                font: dataBitsBox.font
                color: "#ff7e00"
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }

        ComboBox {
            id: parityBox
            width: parent.width / 2
            height: parent.height * 0.2
            anchors.top: dataBitsBox.bottom
            anchors.right: parent.right
            model: ['None', 'Even', 'Odd', 'Mark', 'Space']
            contentItem: Text {
                leftPadding: 10
                text: parityBox.displayText
                font: parityBox.font
                color: "#ff7e00"
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }

        ComboBox {
            id: stopBitsBox
            width: parent.width / 2
            height: parent.height * 0.2
            anchors.top: parityBox.bottom
            anchors.right: parent.right
            model: [1, 1.5, 2]
            contentItem: Text {
                leftPadding: 10
                text: stopBitsBox.displayText
                font: stopBitsBox.font
                color: "#ff7e00"
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }

        ComboBox {
            id: flowControlBox
            width: parent.width / 2
            height: parent.height * 0.2
            anchors.top: stopBitsBox.bottom
            anchors.right: parent.right
            model: ['None', 'RTS/CTS', 'XON/XOFF']
            contentItem: Text {
                leftPadding: 10
                text: flowControlBox.displayText
                font: flowControlBox.font
                color: "#ff7e00"
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }

        Text {
            anchors.top: text8.bottom
            anchors.left: parent.left
            anchors.right: baudRateBox.left
            anchors.topMargin: 10
            text: qsTr("Baud Rate:")
            color: "white"
        }

        Text {
            anchors.top: baudRateBox.bottom
            anchors.left: parent.left
            anchors.right: dataBitsBox.left
            anchors.topMargin: 10
            text: qsTr("Data bits:")
            color: "white"
        }

        Text {
            anchors.top: dataBitsBox.bottom
            anchors.left: parent.left
            anchors.right: parityBox.left
            anchors.topMargin: 10
            text: qsTr("Parity:")
            color: "white"
        }

        Text {
            anchors.top: parityBox.bottom
            anchors.left: parent.left
            anchors.right: stopBitsBox.left
            anchors.topMargin: 10
            text: qsTr("Stop bits:")
            color: "white"
        }

        Text {
            anchors.top: stopBitsBox.bottom
            anchors.left: parent.left
            anchors.right: flowControlBox.left
            anchors.topMargin: 10
            text: qsTr("Flow control:")
            color: "white"
        }
    }

    Frame {
        width: parent.width - 20
        height: parent.height * 0.2
        anchors.top: selectPortFrame.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 10

        Text {
            id: text9
            anchors.top: parent.top
            anchors.left: parent.left
            text: qsTr("Additional options")
            color: "white"
        }

        CheckBox {
            id: localEchoBox
            anchors.top: parent.top
            anchors.left: text9.right
            checked: true
            text: qsTr("Local echo")
        }
    }

    Button {
        id: applyPortsButton
        width: parent.width * 0.12
        height: parent.height * 0.12
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 10
        background: Rectangle {
            implicitWidth: parent.width
            implicitHeight: parent.height
            color: applyPortsButton.down ? "#ffff00" : "#ff7e00"
            radius: 4
        }
        text: qsTr("Apply")

        onClicked: {
            appcore.setSPPortProperties(chosePortBox.currentText, baudRateBox.currentText,
                                        dataBitsBox.currentText, parityBox.currentText,
                                        stopBitsBox.currentText, flowControlBox.currentValue,
                                        localEchoBox.checkState)
            root.close()
        }
    }
}

