#include "widget.h"
#include <QtGui>

Widget::Widget(QWidget *parent) :
    QWidget(parent),
    m_pQmlContainer(0),
    m_shadow("qml/Image/window_shadow.png")
{
    m_pQmlContainer = new QDeclarativeView(this);
    QHBoxLayout* layout = new QHBoxLayout(this);
    layout->addWidget(m_pQmlContainer);
    layout->setContentsMargins(5, 3, 5, 7);
    setLayout(layout);
    setFixedSize(1310, 810);

    setWindowFlags(Qt::FramelessWindowHint | Qt::WindowSystemMenuHint | Qt::WindowMinimizeButtonHint);
    setAttribute(Qt::WA_TranslucentBackground);
    setStyleSheet("background:transparent;");

    m_pQmlContainer->rootContext()->setContextProperty("window", this);
}

Widget::~Widget()
{
}

// draw window shadow
void Widget::paintEvent(QPaintEvent *e)
{
    QPainter painter(this);

    QRect bottom(5, 136, 200, 7);
    QRect top(5, 0, 200, 3);
    QRect left(0, 3, 5, 133);
    QRect right(205, 3, 5, 133);
    QRect topRight(205, 0, 5, 3);
    QRect topLeft(0, 0, 5, 3);
    QRect bottomLeft(0, 136, 5, 7);
    QRect bottomRight(205, 136, 5, 7);

    QRect tBottom(207, 657- 7, 1010 - 10, 7);
    QRect tTop(207, 46, 1010  - 10, 3);
    QRect tLeft(202, 50, 5, 610 - 10);
    QRect tRight(1212  - 5, 50, 5, 610 - 10);
    QRect tTopLeft(202, 46, 5, 3);
    QRect tTopRight(1212  - 5, 46, 5, 3);
    QRect tBottomLeft(202, 658 - 7, 5, 7);
    QRect tBottomRight(1212  - 5, 658 - 7, 5, 7);

    painter.drawPixmap(tBottom, m_shadow, bottom);
    painter.drawPixmap(tTop, m_shadow, top);
    painter.drawPixmap(tLeft, m_shadow, left);
    painter.drawPixmap(tRight, m_shadow, right);
    painter.drawPixmap(tTopRight, m_shadow, topRight);
    painter.drawPixmap(tTopLeft, m_shadow, topLeft);
    painter.drawPixmap(tBottomLeft, m_shadow, bottomLeft);
    painter.drawPixmap(tBottomRight, m_shadow, bottomRight);
}

void Widget::showEvent(QShowEvent *e)
{
    // Necessary! If not do this, when you minimize the window
    // and restore, the button will ignore the hover event.
    repaint();
}

bool Widget::SetQmlFile(QString qmlFile)
{
    if ( QFile::exists(qmlFile) )
    {
        m_pQmlContainer->setSource(QUrl::fromLocalFile(qmlFile));
        return true;
    }
    else
    {
        return false;
    }
}
