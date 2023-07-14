#ifndef STT_H
#define STT_H

#include <QObject>
#include <QProcess>

class STT : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString searchkey READ searchkey NOTIFY recognitionResult)

public:
    explicit STT(QObject *parent = nullptr);

public slots:
    void executeSTT();
    QString searchkey() const;

signals:
    void recognitionResult();

private:
    QProcess *process;
    QString searchKey;
};

#endif // STT_H
