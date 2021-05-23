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

private:
    QSerialPort *m_console = nullptr;
};

#endif // CONSOLE_H
