#ifndef QQMLTEST_H
#define QQMLTEST_H

#include <QObject>

class QQmlTest : public QObject
{
    Q_OBJECT
public:
    explicit QQmlTest(QObject *parent = 0);

signals:

public slots:
   void spInfo();
};

#endif // QQMLTEST_H
