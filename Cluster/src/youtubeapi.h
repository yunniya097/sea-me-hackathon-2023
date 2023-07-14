#ifndef YOUTUBEAPI_H
#define YOUTUBEAPI_H

#include <QNetworkRequest>
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QUrl>

class YoutubeAPI : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString url_youtube READ url_youtube NOTIFY urlUpdated)

public:
    explicit YoutubeAPI(QWidget *parent = nullptr);
    Q_INVOKABLE void requestVideo(const QString &keyword);

    QString url_youtube() const;

signals:
    void urlUpdated();

private slots:
    void onVideoDataReceived(QNetworkReply *reply);

private:
    QNetworkAccessManager *networkManager;

    QString apiKey;
    QString final_url;



};

#endif // YOUTUBEAPI_H
