#ifndef QMYIMAGE_H
#define QMYIMAGE_H
#include "lzss.h"
#include <QObject>
class QMyImage : public QObject
{
    Q_OBJECT
    LZSS *imLzss;
    bool reverseCode;
    bool im_Direct;
    int maxBufferSize;
    QStringList *files;
    QStringList *filesOut;
    QString pixInfo;
    QString qstr;
public:
    explicit QMyImage(QObject *parent = 0);
    bool pixelInfo(const QString &,int nNum);
signals:

public slots:
    void imOpen();
    void setReverseCodeC();
    void setReverseCodeD();
    //void pixelInfo();
    void setDeDirectC();
    void setDeDirectD();
    void saveToText();
    QString imageFrame(int num);
    int numofImage();
    void compressFile(QString,QString,int);
    void uncompressFile(QString,QString,int);
    bool setBufferSize(QString);
    QString dataToCompress();
    QString sendlzData();
    unsigned long dataCompress(QString picPixel);
};

#endif // QMYIMAGE_H
