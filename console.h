#ifndef CONSOLE_H
#define CONSOLE_H

#include <QSerialPort>
#include <settingsport.h>

class Console
{
public:
    Console();
    ~Console();

    void openSerialPort(const Port &settingsPort);
    void closeSerialPort();

    void sendCommand(QString command);

private:
    QSerialPort *m_console = nullptr;
};

#endif // CONSOLE_H
