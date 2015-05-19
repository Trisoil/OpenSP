#include <stdio.h>
#include "qmyconsole.h"
#include <QDebug>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QClipboard>
#include <QApplication>
#include <QByteArray>
#include <QMutexLocker>
#include <QMessageBox>
#include <QDebug>
#include <QSettings>
#include <QTime>

QT_USE_NAMESPACE

QMyconsole *QMyconsole::MsgHandler=NULL;

QMyconsole::QMyconsole(QObject *parent) :
    QObject(parent)
{ 
    playState=false;
    sIniFilePath ="config.ini";
    mediaPlayer.setMedia (QUrl::fromLocalFile("Sound/Nyan Cat.mp3"));
    openFlag=true;
    messageRequ="";
    waitTimeOut=1000;
    m_period=0;
    sIniSetting=new QSettings(sIniFilePath,QSettings::IniFormat);
    sIniSetting->setIniCodec ("UTF-8");
    if(!sIniSetting->value ("Init/LanuchTime",0).toInt ())
    {
          sIniSetting->setValue ("Init/LanuchTime",1);
          sIniSetting->setValue ("Widget/Lefft",true);
          sIniSetting->setValue ("Widget/Bottom",true);
          sIniSetting->setValue ("Widget/Right",true);
          sIniSetting->setValue ("Widget/Neko",true);
    }
    enablePeriod=false;
    QMyconsole::MsgHandler=this;
    board=QApplication::clipboard();
    board->setText(NULL,QClipboard::Clipboard);
    port = new QSerialPort();
    foreach (const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts())
    {port->setPortName (serialPortInfo.portName ());
        combusy=serialPortInfo.isBusy ();}
    port->open (QIODevice::ReadWrite);
}
void QMyconsole::toClipboard (QString text)
{
    board->clear ();
    QByteArray ba=text.toLatin1 ();
    const char *c_str2=ba.data ();
    board->setText(c_str2,QClipboard::Clipboard);
}
void QMyconsole::clearclipboard ()
{
    board->clear ();
}
void QMyconsole::playFile ()
{
   playState=!playState;
   if(playState)mediaPlayer.play ();
   else mediaPlayer.pause();
}

void QMyconsole::nNumbe ()
{
     QString text;
     text= QString("Number of serial ports:%1\n").
             arg(QSerialPortInfo::availablePorts().count());
     text.append (board->text ().toLatin1 ());
     toClipboard (text);
}
void QMyconsole::closeWidget (int which)
{
    switch (which) {
    case 0:
      sIniSetting->setValue ("Widget/Lefft",false);
        break;
    case 1:
      sIniSetting->setValue ("Widget/Bottom",false);
        break;
    case 2:
      sIniSetting->setValue ("Widget/Right",false);
        break;
    case 3:
      sIniSetting->setValue ("Widget/Neko",false);
        break;
    default:
        break;
    }
}
bool QMyconsole::enableWidget (int which)
{
     switch(which){
     case 0:
       return sIniSetting->value ("Widget/Lefft",false).toBool ();
     case 1:
       return sIniSetting->value ("Widget/Bottom",false).toBool ();
     case 2:
       return sIniSetting->value ("Widget/Right",false).toBool ();
     case 3:
       return sIniSetting->value ("Widget/Neko",false).toBool ();
     default:
       return false;
     }
}

void QMyconsole::setBaud_com (QString comname)
{
     QByteArray ba=comname.toLatin1 ();
     qint32 c_str2=ba.toInt ();
     port->setBaudRate (c_str2,QSerialPort:: AllDirections);
}
void QMyconsole::setCom (QString comname)
{
    port->close ();
    port->setPortName (comname);
    if(!port->open (QIODevice::ReadWrite)){
     toClipboard (QString("Can't open %1, error code %2\n\n")
                  .arg(port->portName ()).arg(port->error()));
    }
    else{
        toClipboard (QString("The %1 has opened.\n\n")
                     .arg(port->portName ()));
    }
}
void QMyconsole::setParity_com (int value)
{
    if(value!=0)value=value+1;
    switch (value) {
    case 0:
        port->setParity (QSerialPort::NoParity);
        break;
    case 2:
        port->setParity (QSerialPort::EvenParity);
        break;
    case 3:
        port->setParity (QSerialPort::OddParity);
        break;
    case 4:
        port->setParity (QSerialPort::SpaceParity);
        break;
    case 5:
        port->setParity (QSerialPort::MarkParity);
        break;
    default:
        break;
    }
}
void QMyconsole::setDatabit_com (int datebits)
{
    switch (datebits) {
    case 0:
        port->setDataBits (QSerialPort::Data5);
        break;
    case 1:
        port->setDataBits (QSerialPort::Data6);
        break;
    case 2:
        port->setDataBits (QSerialPort::Data7);
        break;
    case 3:
        port->setDataBits (QSerialPort::Data8);
        break;
    default:
        break;
    }
}
void QMyconsole::setStopbit_com (int stopbit)
{
    switch (stopbit) {
    case 0:
        port->setStopBits (QSerialPort::OneStop);
        break;
    case 1:
        port->setStopBits (QSerialPort::OneAndHalfStop);
        break;
    case 2:
        port->setStopBits (QSerialPort::TwoStop);
        break;
    default:
        break;
    }
}
void QMyconsole::setFlowControl_com (int fc)
{
    switch (fc) {
    case 0:
        port->setFlowControl (QSerialPort::NoFlowControl);
        break;
    case 1:
        port->setFlowControl (QSerialPort::HardwareControl);
        break;
    case 2:
        port->setFlowControl (QSerialPort::SoftwareControl);
        break;
    default:
        break;
    }
}
void QMyconsole::setWaitOutTime (QString time)
{
    waitTimeOut=time.toInt ();
}

void QMyconsole::setPeriod (QString time)
{
   m_period=time.toInt ();
}
void QMyconsole::enPeriod (bool states)
{
    enablePeriod=states;
}

bool QMyconsole::busy_com ()
{
    return combusy;
}
bool QMyconsole::isOpen ()
{
return openFlag;
}

bool QMyconsole::comStateChange ()
{
    if(openFlag)
    {
        port->close ();
        openFlag=false;
        toClipboard (QString("The %1 has closed.\n\n")
                     .arg(port->portName ()));
        return true;
    }
    else {
        if(!port->open (QIODevice::ReadWrite)){
         toClipboard (QString("Can't open %1, error code %2\n\n")
                      .arg(port->portName ()).arg(port->error()));
         if(port->error ()==QSerialPort::OpenError)
         {
             toClipboard (QString("The %1 has opened.\n\n")
                          .arg(port->portName ()));
             return true;
         }
         openFlag=false;
         return false;
        }
        else{
            toClipboard (QString("The %1 has opened.\n\n")
                         .arg(port->portName ()));
         openFlag=true;
         return true;
        }
    }
}
QString QMyconsole::nowComAvailab (int nNum)
{

    foreach (const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts())
       { nNum--;
        if(nNum);
        else{
            return serialPortInfo.portName();
        }
    }
    return NULL;
}

void QMyconsole::nowSpinfo ()
{
    QString text,txtinfo,txtavailab;
    foreach (const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts())
    {
        txtavailab= QString("Port:%1\nLocation:%2\nDescription:%3\nManufacturer:%4\nVendor Identifier:%5\nProduct Identifier:%6\nBusy:%7\n").
                arg(serialPortInfo.portName()).arg(serialPortInfo.systemLocation())
                .arg(serialPortInfo.description()).arg(serialPortInfo.manufacturer())
                .arg((QString)(serialPortInfo.hasVendorIdentifier() ? QByteArray::number(serialPortInfo.vendorIdentifier(), 16) : QByteArray()))
                .arg((QString)(serialPortInfo.hasProductIdentifier() ? QByteArray::number(serialPortInfo.productIdentifier(), 16) : QByteArray()))
                .arg((serialPortInfo.isBusy() ? QObject::tr("Yes") : QObject::tr("No")));
                QSerialPort *m_port = new QSerialPort(serialPortInfo);
                if (m_port->open(QIODevice::ReadWrite)) {
                    txtinfo= QString("Baud rate:%1\nData bits:%2\nStop bits:%3\nParity:%4\nFlow control:%5\nRead buffer size:%6\n\n").
                            arg( m_port->baudRate()).arg(m_port->dataBits()).arg(m_port->stopBits())
                            .arg(m_port->parity()).arg(m_port->flowControl()).arg(m_port->readBufferSize());
                    m_port->close();
                } else{
                    txtinfo= QString("Unable to open port, error code%1\n").
                                                arg(m_port->error());
                }
                txtavailab.append (txtinfo);
                text.append (txtavailab);
                delete m_port;
    }
    toClipboard (text);
}
bool QMyconsole::emitMessageRequ (QString message)
{
    messageRequ=message;
    int currentWaitTimeOut=waitTimeOut;
    QByteArray messageDate=message.toLocal8Bit ();
    port->write (messageDate);
    QTime currentTime=QTime::currentTime();
    if (port->waitForBytesWritten(waitTimeOut)) {
    if(port->waitForReadyRead (currentWaitTimeOut)){
        QByteArray responseDate=port->readAll ();
        while(port->waitForReadyRead (10))
            responseDate+=port->readAll ();
        QString response(responseDate);
        toClipboard (QString("response:%1\n\n").
                     arg (response));
        return true;
        }
        else{
        toClipboard (QString("Wait write request timeout %1\n\n")
                     .arg(currentTime.msecsTo (QTime::currentTime())));
            //超时
        return false;
        }
  }
    else{
        toClipboard (QString("Could not touch the serial port,Wait write request timeout %1\n\n")
                     .arg(currentTime.msecsTo (QTime::currentTime())+100));
        //超时
        return false;
    }
}

QString QMyconsole::QtMsgToQString (QtMsgType type, const char *msg)
{
    switch (type) {
    case QtDebugMsg:
        return QLatin1String("Debug: ")+QLatin1String(msg);
    case QtWarningMsg:
        return QLatin1String("Warning: ")+QLatin1String(msg);
    case QtCriticalMsg:
        return QLatin1String("Critical: ")+QLatin1String(msg);
    case QtFatalMsg:
        return QLatin1String("Fatal: ")+QLatin1String(msg);
    default:
        return QLatin1String("Unrecognized message type: ")+QLatin1String(msg);
    }
}

void QMyconsole::AppendMsgWrapper (QtMsgType type, const char *msg)
{
    static QMutex mutex;
    QMutexLocker locker(&mutex);

    if (QMyconsole::MsgHandler != NULL)
        return QMyconsole::MsgHandler->postMsgEvent(type, msg);
    else
        fprintf(stderr, "%s", QMyconsole::QtMsgToQString(type, msg).toLatin1().data());
}

void QMyconsole::customEvent(QEvent *event)
{
    if (static_cast<QMyconsole::EventType>(event->type()) == QMyconsole::MessageEventType)
        //msgTextEdit.append(dynamic_cast<MessageEvent *>(event)->msg);
        QMyconsole::toClipboard (dynamic_cast<MessageEvent *>(event)->msg);
}

void QMyconsole::postMsgEvent(QtMsgType type, const char *msg)
{
    QString qmsg = QMyconsole::QtMsgToQString(type, msg);
    switch (type) {
    case QtDebugMsg:
        break;
    case QtWarningMsg:
        qmsg.prepend(QLatin1String("<FONT color=\"#FF0000\">"));
        qmsg.append(QLatin1String("</FONT>"));
        break;
    case QtCriticalMsg:
        /*if (QMessageBox::critical(this, QLatin1String("Critical Error"), qmsg,
                                  QMessageBox::Ignore,
                                  QMessageBox::Abort,
                                  QMessageBox::NoButton) == QMessageBox::Abort)
            abort(); // core dump*/
        qmsg.prepend(QLatin1String("<B><FONT color=\"#FF0000\">"));
        qmsg.append(QLatin1String("</FONT></B>"));
        break;
    case QtFatalMsg:
        //QMessageBox::critical(this, QLatin1String("Fatal Error"), qmsg, QMessageBox::Ok, QMessageBox::NoButton, QMessageBox::NoButton);
        abort(); // deliberately core dump
    }
    //it's impossible to change GUI directly from thread other than the main thread
    //so post message encapsulated by MessageEvent to the main thread's event queue
    QCoreApplication::postEvent(this, new MessageEvent(qmsg));
}
#if QT_VERSION >= QT_VERSION_CHECK(5,0,0)
void QMyconsole::AppendMsgWrapper(QtMsgType type, const QMessageLogContext & /*context*/, const QString &msg)
{
    AppendMsgWrapper(type, msg.toLatin1().data());
}
#endif

QMyconsole::~QMyconsole ()
{
   port->close();
   delete port;
}

MessageEvent::MessageEvent(QString &msg):
    QEvent(static_cast<QEvent::Type>(QMyconsole::MessageEventType))
{
    this->msg=msg;
}
