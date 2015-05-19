#ifndef WIDGET_H
#define WIDGET_H

#include <QtGui>
#include <QtDeclarative>
#include <QPixmap>

class Widget : public QWidget
{
    Q_OBJECT
    
public:
    explicit Widget(QWidget *parent = 0);
    ~Widget();

public:
    bool SetQmlFile(QString QmlFile);

protected:
    void paintEvent(QPaintEvent *e);
    void showEvent(QShowEvent *e);
    
private:
    QDeclarativeView* m_pQmlContainer;
    QPixmap m_shadow;
};

#endif // WIDGET_H
