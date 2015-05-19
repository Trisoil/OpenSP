#ifndef QMYCONSOLE_H
#define QMYCONSOLE_H
#include <QObject>
#include <QEvent>
#include <QMediaPlayer>
class QClipboard;
class QSerialPort;
class QSettings;
class QMyconsole : public QObject
{
    Q_OBJECT
    static QMyconsole *MsgHandler;
    QSettings *sIniSetting;
    bool openFlag;
    bool combusy;
    bool playState;
    bool enablePeriod;
public:
    explicit QMyconsole(QObject *parent = 0);
    ~QMyconsole();
    enum EventType{MessageEventType=QEvent::User};
    static void AppendMsgWrapper(QtMsgType type,const char *msg);
#if QT_VERSION >=QT_VERSION_CHECK(5,0,0)
    static void AppendMsgWrapper (QtMsgType type, const QMessageLogContext &context,const QString &msg);
#endif
    void postMsgEvent(QtMsgType type,const char *msg);
    QClipboard *board;
    QSerialPort *port;
signals:

public slots:
    void nNumbe();
    void nowSpinfo();
    void toClipboard(QString text);
    void setBaud_com(QString comname);
    void setCom(QString comname);
    void setParity_com(int value);
    void setDatabit_com(int datebits);
    void setStopbit_com(int stopbit);
    void setFlowControl_com(int fc);
    bool busy_com();
    bool comStateChange();
    void clearclipboard();
    bool emitMessageRequ(QString message);
    void setWaitOutTime(QString time);
    void setPeriod(QString time);
    void enPeriod(bool states);
    void playFile();
    bool isOpen();
    void closeWidget(int which);
    bool enableWidget(int which);
    QString nowComAvailab(int nNum);
private:
    static QString QtMsgToQString(QtMsgType type,const char *msg);
    QMediaPlayer mediaPlayer;
    QString messageRequ;
    QString sIniFilePath;
    int waitTimeOut;
    int m_period;
protected:
    virtual void customEvent (QEvent *event);
};

class MessageEvent:public QEvent
{
public :
    QString msg;
    MessageEvent(QString &msg);
};

#endif // QMYCONSOLE_H
