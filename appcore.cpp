#include "appcore.h"

#include <QDebug>

AppCore::AppCore(QObject *parent) : QObject(parent), m_settingsPort(), m_console()
{
    m_chosePort = -1;
}

void AppCore::setSPPortProperties(QString name, QString baudRate, QString dataBits,
                                  QString parity, QString stopBits, QString flowControl,
                                  bool localEchoEnabled)
{
    m_settingsPort.setPortProperties(name, baudRate, dataBits, parity, stopBits, flowControl, localEchoEnabled);
}

void AppCore::connectConsole()
{
    m_console.openSerialPort(m_settingsPort.getPort(m_chosePort));
}

void AppCore::disconnectConsole()
{
    m_console.closeSerialPort();
}

void AppCore::sendCommand(QString command)
{
    m_console.sendCommand(command);
}

int AppCore::getChosePort()
{
    return m_chosePort;
}

void AppCore::setChosePort(int idx)
{
    m_chosePort = idx;
}

int AppCore::getSPSizePorts()
{
    return m_settingsPort.getSizePorts();
}

QStringList AppCore::getSPName()
{
    return m_settingsPort.getName();
}

QStringList AppCore::getSPDescription()
{
    return m_settingsPort.getDescription();
}

QStringList AppCore::getSPManufacturer()
{
    return m_settingsPort.getManufacturer();
}
QStringList AppCore::getSPSerialNumber()
{
    return m_settingsPort.getSerialNumber();
}

QStringList AppCore::getSPLocation()
{
    return m_settingsPort.getLocation();
}

QStringList AppCore::getSPVendorIdentifier()
{
    return m_settingsPort.getVendorIdentifier();
}

QStringList AppCore::getSPProductIdentifier()
{
    return m_settingsPort.getProductIdentifier();
}
