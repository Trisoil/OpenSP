#include "qmyimage.h"
#include "qmyconsole.h"
#include <QFileDialog>
#include <QImageReader>
#include <QStandardPaths>
#include <QMessageBox>
#include <QGuiApplication>
#include <QtMath>
#include <QTextStream>

QMyImage::QMyImage(QObject *parent) :
    QObject(parent)
{
    reverseCode=false;
    im_Direct=false;
    files=new QStringList();
    filesOut=new QStringList();
    pixInfo=QString();
    maxBufferSize=81024;
    imLzss=new LZSS();
    qstr="";
}

void QMyImage::imOpen ()
{
    /*QStringList mimeTypeFilters;
    options|=QFileDialog::DontUseNativeDialog;
    //foreach (const QByteArray &mimeTypeName, QImageReader::supportedMimeTypes())
        //mimeTypeFilters.append(mimeTypeName);
    //mimeTypeFilters.sort();//其他文件支持
    mimeTypeFilters<<"image/bmp";
    const QStringList picturesLocations = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    QFileDialog dialog(NULL, tr("Open File"),
                       picturesLocations.isEmpty() ? QDir::currentPath() : picturesLocations.first());
    dialog.setAcceptMode(QFileDialog::AcceptOpen);
    dialog.setMimeTypeFilters(mimeTypeFilters);
    dialog.selectMimeTypeFilter("image/bmp");*///单个文件
    QFileDialog::Options options;
    QStringList picturesLocations = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    options|=QFileDialog::DontUseNativeDialog;
    files->append ( QFileDialog::getOpenFileNames(
                            NULL,
                            "Select one or more files to open",
                             picturesLocations.isEmpty() ? QDir::currentPath() : picturesLocations.first(),
                            "Images (*.bmp)"));
    //while (dialog.exec() == QDialog::Accepted && !loadFile(dialog.selectedFiles().first())) {}
}

void QMyImage::saveToText ()
{
    for(int i=0;i<files->count ();i++)
    pixelInfo (files->value (i),i);
}

QString QMyImage::dataToCompress ()
{
return pixInfo;
}

bool QMyImage::pixelInfo(const QString &fileName,int nNum)
{
    QImage image(fileName);
    if (image.isNull()) {
        QMessageBox::information(NULL, QGuiApplication::applicationDisplayName(),
                                 tr("Cannot load %1.").arg(QDir::toNativeSeparators(fileName)));
    //setWindowFilePath(QString());  //Windows平台限定
        return false;
    }
    QRgb imRgb;
    QMyconsole qmycon;
    int blue;
    int m_bits=0;
    int count=0;
    int n_height=0;
    int n_return=0;
    //横向取模
    if(im_Direct){
    for(int j=0;j<image.height ();j++){
    for (int i=0;i<image.width ();i++)
    {
      imRgb=image.pixel (i,j);
      blue=qBlue(imRgb)?0:1;
      if(reverseCode)blue=!blue;
      if(blue)m_bits+=qPow(2,count);
      count++;
      if(count>7){
      pixInfo.append (QString("0x%1,").arg (m_bits&0xFF,2,16,QLatin1Char('0')));//十六进制转换
      count=0;
      m_bits=0;
      }
    }
      pixInfo.append ("\n");
   }}else{
    //纵向取模
    for(int x=0;x<(image.height ()/8);x++){
    for(int i=0;i<image.width ();i++){
        for(n_height=x*8;n_height<x*8+8;n_height++){
            imRgb=image.pixel (i,n_height);
        blue=qBlue(imRgb)?0:1;
        if(reverseCode)blue=!blue;
        if(blue)m_bits+=qPow(2,n_height%8);
        }
        pixInfo.append (QString("0x%1,").arg (m_bits&0xFF,2,16,QLatin1Char('0')));//十六进制转换
        m_bits=0;
        n_return++;
        if(n_return>15){
            pixInfo.append ("\n");
            n_return=0;
             }
        }
    }}
    qmycon.toClipboard (QString("The %1st file has completed\n").arg (nNum));
    //存为文本
    QDir* BWout=new QDir;
    bool exist=BWout->exists (QDir::currentPath().append ("\\BWout"));
    if(!exist) BWout->mkdir (QDir::currentPath().append ("\\BWout"));
    QFile file(QDir::currentPath().append (QString("\\BWout\\B%1.txt").arg (nNum)));
    if (!file.open(QFile::WriteOnly | QFile::Text)) {
        QMessageBox::warning(NULL, tr("Error"),
                             tr("Cannot write file %1:\n%2.")
                             .arg(fileName)
                             .arg(file.errorString()));
        return false;
    }
    QTextStream out(&file);
    QGuiApplication::setOverrideCursor(Qt::WaitCursor);
    out << pixInfo;
    QGuiApplication::restoreOverrideCursor();
    //setWindowFilePath(fileName);
    return true;
}

unsigned long QMyImage::dataCompress (QString picPixel)
{

    int length=picPixel.length ();
    unsigned char* sequence=NULL;
    sequence=(unsigned char*)qstrdup (picPixel.toLatin1 ().constData());
    unsigned long ofLeng;
    unsigned char *temp  = new unsigned char[length];
    QString s;
    ofLeng=imLzss->Compress (sequence,length,temp);
    //int rev=strlen (reinterpret_cast<const char*>(temp));
    for(unsigned long i=0;i<ofLeng;i++){
      s=QString("%1").arg (temp[i],0,16);
      if(s.length ()==1){
          qstr.append ("0");
      }
      qstr.append (s);
    }
    filesOut->append (qstr);
    qstr.append ("\n");
      QMyconsole qmycon;
      unsigned char *unCom  = new unsigned char[maxBufferSize];
      QChar toasc;
      imLzss->UnCompress (temp,qstr.length (),unCom);
      for(unsigned long i=0;i<length;i++){
      s=QString("%1").arg (unCom[i],0,16);
      toasc=QChar(s.toInt (0,16));   //toAscii
      qstr.append (toasc);
    }
    qmycon.toClipboard (qstr);
    return ofLeng;
}
QString QMyImage::sendlzData(){
     return qstr;
}

void QMyImage::compressFile (QString infile, QString com,int count)
{
    //压缩文件
    FILE *in;
    FILE *f_com;
    unsigned long len_compress;
    unsigned long len_src;
    unsigned char *buffer_src  = new unsigned char[maxBufferSize];
    unsigned char *buffer_compress  = new unsigned char[maxBufferSize];

    in=fopen((QString("%1B%2.txt").arg (infile).arg (count)).toStdString ().data (),"r");
    f_com=fopen((QString("%1LZ%2.txt").arg (com).arg (count)).toStdString ().data (),"w");

    len_src=fread(buffer_src,sizeof(char),maxBufferSize-1,in);
    len_compress=imLzss->Compress(buffer_src,len_src,buffer_compress);
    fwrite(buffer_compress,sizeof(char),len_compress,f_com);
    fclose(in);
    fclose(f_com);
}
void QMyImage::uncompressFile (QString infile, QString uncom,int count)
{
    //解压文件
    FILE *in;
    FILE *f_uncom;
    unsigned long len_src;
    unsigned long len_uncompress = maxBufferSize;
    unsigned char *buffer_src  = new unsigned char[maxBufferSize];
    unsigned char *buffer_uncompress = new unsigned char[maxBufferSize];
    in=fopen((QString("%1B%2.txt").arg (infile).arg (count)).toStdString ().data (),"r");
    f_uncom=fopen((QString("%1unLZ%2.txt").arg (uncom).arg (count)).toStdString ().data (),"w");
    len_src=fread(buffer_src,sizeof(char),maxBufferSize-1,in);
    len_uncompress=imLzss->UnCompress (buffer_src,len_src,buffer_uncompress);
    fwrite(buffer_uncompress,sizeof(char),len_uncompress,f_uncom);
    fclose(in);
    fclose(f_uncom);
}

bool QMyImage::setBufferSize (QString bs)
{
    bool ok;
    maxBufferSize=bs.toInt (&ok,10);
    return ok;
}

QString QMyImage::imageFrame (int num)
{
   return files->value (num);
}

int QMyImage::numofImage ()
{
  return files->count ();
}

void QMyImage::setReverseCodeC ()
{
    reverseCode=true;
}

void QMyImage::setReverseCodeD ()
{
    reverseCode=false;
}

void QMyImage::setDeDirectC ()
{
   im_Direct=true;
}

void QMyImage::setDeDirectD ()
{
   im_Direct=false;
}


