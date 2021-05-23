#include "settingsport.h"

#include <QSerialPortInfo>
#include <QDebug>

QSerialPort::Parity checkPartity(QString partity);
QSerialPort::StopBits checkStopBits(QString stopBits);
QSerialPort::FlowControl checkFlowControl(QString flowControl);

SettingsPort::SettingsPort()
{
    QList<QSerialPortInfo> portsAvailble = QSerialPortInfo::availablePorts();
    m_sizePorts = portsAvailble.size();
    m_ports = new Port[m_sizePorts];

    for(int i = 0; i < m_sizePorts; i++)
    {
        m_ports[i].name = portsAvailble[i].portName();
        m_ports[i].description = portsAvailble[i].description();
        m_ports[i].manufacturer = portsAvailble[i].manufacturer();
        m_ports[i].serialNumber = portsAvailble[i].serialNumber();
        m_ports[i].location = portsAvailble[i].systemLocation();
        m_ports[i].vendorIdentifier = portsAvailble[i].vendorIdentifier();
        m_ports[i].productIdentifier = portsAvailble[i].productIdentifier();
    }
}

SettingsPort::~SettingsPort()
{
    delete[] m_ports;
}

void SettingsPort::setPortProperties(QString name, QString baudRate, QString dataBits, QString parity, QString stopBits, QString flowControl, bool localEchoEnabled)
{
    int idx;
    for(idx = 0; idx < getSizePorts(); idx++)
    {
        if(name == m_ports[idx].name)
            break;
    }

    qDebug() << idx << m_ports[idx].name;

    m_ports[idx].stringBaudRate = baudRate;
    m_ports[idx].baudRate = baudRate.toInt();
    m_ports[idx].dataBits = static_cast<QSerialPort::DataBits>(dataBits.toInt());
    m_ports[idx].stringDataBits = dataBits;
    m_ports[idx].parity = checkPartity(parity);
    m_ports[idx].stringParity = parity;
    m_ports[idx].stopBits = checkStopBits(stopBits);
    m_ports[idx].stringStopBits = stopBits;
    m_ports[idx].flowControl = checkFlowControl(flowControl);
    m_ports[idx].stringFlowControl = flowControl;
    m_ports[idx].localEchoEnabled = localEchoEnabled;

    qDebug() << m_ports[idx].baudRate;
    qDebug() << m_ports[idx].dataBits;
    qDebug() << m_ports[idx].parity;
    qDebug() << m_ports[idx].stopBits;
    qDebug() << m_ports[idx].flowControl;
}


int SettingsPort::getSizePorts()
{
    return m_sizePorts;
}

QStringList SettingsPort::getName()
{
    QStringList list;
    for(int i = 0; i < m_sizePorts; i++)
        list.append(m_ports[i].name);
    return list;
}

QStringList SettingsPort::getDescription()
{
    QStringList list;
    for(int i = 0; i < m_sizePorts; i++)
        list.append(m_ports[i].description);
    return list;
}

QStringList SettingsPort::getManufacturer()
{
    QStringList list;
    for(int i = 0; i < m_sizePorts; i++)
        list.append(m_ports[i].manufacturer);
    return list;
}

QStringList SettingsPort::getSerialNumber()
{
    QStringList list;
    for(int i = 0; i < m_sizePorts; i++)
        list.append(m_ports[i].serialNumber);
    return list;
}

QStringList SettingsPort::getLocation()
{
    QStringList list;
    for(int i = 0; i < m_sizePorts; i++)
        list.append(m_ports[i].location);
    return list;
}

QStringList SettingsPort::getVendorIdentifier()
{
    QStringList list;
    QString hex;
    for(int i = 0; i < m_sizePorts; i++)
        list.append(hex.setNum(m_ports[i].vendorIdentifier, 16));
    return list;
}

QStringList SettingsPort::getProductIdentifier()
{
    QStringList list;
    for(int i = 0; i < m_sizePorts; i++)
        list.append(QString::number(m_ports[i].productIdentifier));
    return list;
}

QDebug operator<<(QDebug out, const SettingsPort& settingsPort)
{
    for(int i = 0; i < settingsPort.m_sizePorts; i++)
    {
        out.space() << "settingsPort.m_ports[" << i << "]\n";
        out.space() << "{name:" << settingsPort.m_ports[i].name << "\n";
        out.space() << "stringBaudRate:" << settingsPort.m_ports[i].stringBaudRate << "\n";
        out.space() << "stringDataBits:" << settingsPort.m_ports[i].stringDataBits << "\n";
        out.space() << "stringParity:" << settingsPort.m_ports[i].stringParity << "\n";
        out.space() << "stringStopBits:" << settingsPort.m_ports[i].stringStopBits << "\n";
        out.space() << "stringFlowControl:" << settingsPort.m_ports[i].stringFlowControl << "\n";
        out.space() << "localEchoEnabled:" << settingsPort.m_ports[i].localEchoEnabled << "\n";
        out.space() << "description:" << settingsPort.m_ports[i].description << "\n";
        out.space() << "manufacturer:" << settingsPort.m_ports[i].manufacturer << "\n";
        out.space() << "serialNumber:" << settingsPort.m_ports[i].serialNumber << "\n";
        out.space() << "location:" << settingsPort.m_ports[i].location << "\n";
        out.space() << "vendorIdentifier:" << settingsPort.m_ports[i].vendorIdentifier << "\n";
        out.space() << "productIdentifier:" << settingsPort.m_ports[i].productIdentifier << "}\n";
    }

    return out;
}

QSerialPort::Parity checkPartity(QString partity)
{
    if(partity == "Even")
        return QSerialPort::EvenParity;
    else if(partity == "Odd")
        return QSerialPort::OddParity;
    else if(partity == "Mark")
        return QSerialPort::MarkParity;
    else if(partity == "Space")
        return QSerialPort::SpaceParity;
    else
        return QSerialPort::NoParity;
}

QSerialPort::StopBits checkStopBits(QString stopBits)
{
    if(stopBits == "1")
        return QSerialPort::OneStop;
    else if(stopBits == "1.5")
        return QSerialPort::OneAndHalfStop;
    else if(stopBits == "2")
        return QSerialPort::TwoStop;
    else
        return QSerialPort::UnknownStopBits;
}
QSerialPort::FlowControl checkFlowControl(QString flowControl)
{
    if(flowControl == "RTS/CTS")
        return QSerialPort::HardwareControl;
    else if(flowControl == "XON/XOFF")
        return QSerialPort::SoftwareControl;
    else
        return QSerialPort::NoFlowControl;
}










