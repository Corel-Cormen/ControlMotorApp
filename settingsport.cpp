#include "settingsport.h"

#include <QSerialPortInfo>
#include <QDebug>

SettingsPort::SettingsPort(QObject *parent) : QObject(parent)
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
