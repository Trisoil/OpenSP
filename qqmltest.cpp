#include "qqmltest.h"
#include <QMessageBox>

QQmlTest::QQmlTest(QObject *parent) :
    QObject(parent)
{
}
void QQmlTest::spInfo ()
{
    QMessageBox::information(NULL,"Help"
                             ,"   如若使用到自带的LZ压缩算法进行串口通信的话，请打开程序所在文件夹下的lzss文件夹，里面的lzss提供解压方法"
                             ,QMessageBox::Yes|QMessageBox::No,
                             QMessageBox::Yes);
}
