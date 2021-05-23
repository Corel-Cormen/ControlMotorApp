#include "console.h"

#include <QThread>
#include <QDebug>

Console::Console() : m_console(new QSerialPort())
{

}

Console::~Console()
{
    delete m_console;
}

void Console::openSerialPort(const Port &settingsPort)
{
    m_console->setPortName(settingsPort.name);
    m_console->setBaudRate(QSerialPort::Baud115200);
    m_console->setDataBits(settingsPort.dataBits);
    m_console->setParity(settingsPort.parity);
    m_console->setStopBits(settingsPort.stopBits);
    m_console->setFlowControl(settingsPort.flowControl);

    if(m_console->open(QIODevice::ReadWrite))
    {
        qDebug() << settingsPort.name << "is Open";
        QByteArray arr = "\n123";
        m_console->write(arr);
        arr = m_console->readAll();
        while(m_console->waitForReadyRead(500))
            arr.append(m_console->readAll());
        qDebug() << arr;
    }
    else
    {
        qDebug() << "Error" << settingsPort.name << "is not Open";
    }

    closeSerialPort();
}

void Console::closeSerialPort()
{
    if(m_console->isOpen())
    {
        m_console->close();
        qDebug() << "Serial port is Close";
    }
}
