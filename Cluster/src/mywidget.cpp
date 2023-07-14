//#include <QtGui>
//#include "mywidget.h"


//// QLabel 위젯에 현재 시간을 표기하고
//// 1초마다 업데이트하기 위해 QTimer위젯 사용
//MyWidget::MyWidget()
//{
//    setFixedSize(500,100);

//    // QTimer
//    timer = new QTimer(this);
//    connect(timer, SIGNAL(timeout()), this, SLOT(update()));
//    // 일정 시간이 지나면 타임아웃 시그널이 발생해
//    // update() 슬롯 함수에서 처리한다.

//    lbl = new QLabel(QDateTime::currentDateTime().toString());

//    layout = new QHBoxLayout;

//    layout->addWidget(lbl);

//    setLayout(layout);

//    timer->start(1000);
//    // 타임아웃이 되는 간격의 시간
//    // 1000밀리초 = 1초
//}

//void MyWidget::update()
//{
//    QDateTime dateTime = QDateTime::currentDateTime();
//    lbl->setText(dateTime.toString());
//}
