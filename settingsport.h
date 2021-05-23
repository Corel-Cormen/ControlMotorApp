#ifndef SETTINGSPORT_H
#define SETTINGSPORT_H

#include <QSerialPort>

struct Port {
    QString name;
    qint32 baudRate;
    QString stringBaudRate;
    QSerialPort::DataBits dataBits;
    QString stringDataBits;
    QSerialPort::Parity parity;
    QString stringParity;
    QSerialPort::StopBits stopBits;
    QString stringStopBits;
    QSerialPort::FlowControl flowControl;
    QString stringFlowControl;
    bool localEchoEnabled;
    QString description;
    QString manufacturer;
    QString serialNumber;
    QString location;
    quint16 vendorIdentifier;
    quint16 productIdentifier;
};

class SettingsPort
{

public:
    SettingsPort();
    ~SettingsPort();

    friend QDebug operator<<(QDebug out, const SettingsPort& settingsPort);

    int getSizePorts();
    QStringList getName();
    QStringList getDescription();
    QStringList getManufacturer();
    QStringList getSerialNumber();
    QStringList getLocation();
    QStringList getVendorIdentifier();
    QStringList getProductIdentifier();

    void setPortProperties(QString name, QString baudRate, QString dataBits,
                           QString parity, QString stopBits, QString flowControl,
                           bool localEchoEnabled);

private:
    Port *m_ports;
    int m_sizePorts;

};

#endif // SETTINGSPORT_H
