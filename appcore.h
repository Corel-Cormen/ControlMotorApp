#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>
#include "settingsport.h"
#include "console.h"

class AppCore : public QObject
{
    Q_OBJECT
public:
    explicit AppCore(QObject *parent = nullptr);

public slots:

    void setSPPortProperties(QString name, QString baudRate, QString dataBits,
                             QString parity, QString stopBits, QString flowControl,
                             bool localEchoEnabled);
    void connectConsole();
    void disconnectConsole();
    void sendCommand(QString command);

    int getSPSizePorts();
    QStringList getSPName();
    QStringList getSPDescription();
    QStringList getSPManufacturer();
    QStringList getSPSerialNumber();
    QStringList getSPLocation();
    QStringList getSPVendorIdentifier();
    QStringList getSPProductIdentifier();

    int getChosePort();
    void setChosePort(int idx);

private:
    SettingsPort m_settingsPort;
    int m_chosePort;
    Console m_console;
};

#endif // APPCORE_H
