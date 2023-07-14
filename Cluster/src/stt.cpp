#include "stt.h"
#include "wrapper_python.h"

#include <Python.h>
#include <iostream>
#include <QCoreApplication>
#include <QtCore/QDebug>

#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkReply>

#include <QFile>
#include<QTextStream>

STT::STT(QObject *parent) : QObject(parent)
{
    process = new QProcess(this);
}

void STT::executeSTT()
{
    Py_Initialize();
    PyObject *obj = Py_BuildValue("s", "/home/sea/sea-me-hackathon-2023/Cluster/src/SpeechToText.py");
    FILE *file = _Py_fopen_obj(obj, "r+");
    qDebug() << "file open";
    QString myText;
    QString Key;

    if(file != NULL)
    {
       qDebug() << "start";
       PyRun_SimpleFile(file, "/home/sea/sea-me-hackathon-2023/Cluster/src/SpeechToText.py");
       qDebug() << "python program finished";
    } else std::cout << "fail";

    QFile textFile("/home/sea/sea-me-hackathon-2023/Cluster/src/commands.txt");
    if(textFile.open(QFile::ReadOnly | QFile::Text))
    {
        QTextStream in(&textFile);
        myText = in.readAll();
        qDebug() << myText;
        textFile.close();
    }

    QStringList list = myText.split(" ");

    if(list.contains("YouTube"))
    {
        qDebug() << "List contains YouTube";
        list.removeLast();
        list.removeLast();
        list.removeFirst();
        Key = list.join(" ");
    } else if(list.contains("navigation"))
    {
        qDebug() << "List contains navigation";
        list.removeLast();
        list.removeLast();
        list.removeFirst();
        Key = list.join(" ");
    }else
    {
        qDebug() << "List does not contain";
    }

    qDebug() << Key;

    searchKey = Key;

    qDebug() << "finish";
    Py_Finalize();
    emit recognitionResult();
}

QString STT::searchkey() const
{
    qDebug() << searchKey;
    return searchKey;
}
