#ifndef SETTINGSPORT_H
#define SETTINGSPORT_H

#include <QObject>

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

class SettingsPort : public QObject
{
    Q_OBJECT

public:
    SettingsPort(QObject *parent = nullptr);
    ~SettingsPort();

private:
    Port *m_ports;
    int m_sizePorts;

public slots:
    int getSizePorts();
    QStringList getName();
    QStringList getDescription();
    QStringList getManufacturer();
    QStringList getSerialNumber();
    QStringList getLocation();
    QStringList getVendorIdentifier();
    QStringList getProductIdentifier();
};

#endif // SETTINGSPORT_H
