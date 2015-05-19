#include "widget.h"
#include "qqmltest.h"
#include "qmyconsole.h"
#ifndef  QT_IMCONSOLE
#include "qmyimage.h"
#endif
#include <QApplication>
//#include <QtPlugin>
//Q_IMPORT_PLUGIN(qcncodecs)
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    qmlRegisterType<QQmlTest>("QmlTest",1,0,"QQmlTest");
    qmlRegisterType<QMyconsole>("Myconsole",1,0,"QMyconsole");
    qmlRegisterType<QMyImage>("MyImage",1,0,"QMyImage");
    Widget w;
    w.SetQmlFile("qml/qmlmain.qml");
    w.show();
    
    return a.exec();
}
