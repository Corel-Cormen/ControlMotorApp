#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>
#include "settingsport.h"

class AppCore : public QObject
{
    Q_OBJECT
public:
    explicit AppCore(QObject *parent = nullptr);

public slots:

    void setSPPortProperties(QString name, QString baudRate, QString dataBits,
                             QString parity, QString stopBits, QString flowControl,
                             bool localEchoEnabled);

    int getSPSizePorts();
    QStringList getSPName();
    QStringList getSPDescription();
    QStringList getSPManufacturer();
    QStringList getSPSerialNumber();
    QStringList getSPLocation();
    QStringList getSPVendorIdentifier();
    QStringList getSPProductIdentifier();

private:
    SettingsPort m_settingsPort;

};

#endif // APPCORE_H
