#include "console.h"

#include <QThread>
#include <QDebug>

Console::Console() : m_console(new QSerialPort())
{

}

Console::~Console()
{
    closeSerialPort();
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
//        QByteArray arr = "\n123";
//        m_console->write(arr);
//        arr = m_console->readAll();
//        while(m_console->waitForReadyRead(500))
//            arr.append(m_console->readAll());
//        qDebug() << arr;
    }
    else
    {
        qDebug() << "Error" << settingsPort.name << "is not Open";
    }
}

void Console::closeSerialPort()
{
    if(m_console->isOpen())
    {
        m_console->close();
        qDebug() << "Serial port is Close";
    }
}

void Console::sendCommand(QString command)
{
    static int nativePosition = 0;
    qDebug() << nativePosition;

    if(nativePosition == command[5])
        return;

    nativePosition = command[5].unicode() - 59;
    m_console->write(command.toStdString().c_str(), command.size());
    qDebug() << command;

    QByteArray reply;
    reply = m_console->readAll();
    while(m_console->waitForReadyRead(500)) {
        reply.append(m_console->readAll());
    }
    qDebug() << reply;

    if(reply == "1")
    {
        qDebug() << "Command Succes";
        m_console->clear();
        m_console->write("\r");
    }
    else
    {
        qDebug() << "Command Error";
        m_console->clear();
        m_console->write("\r");
    }
}
