#include "youtubeapi.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkReply>
#include <QJsonValue>
#include <QWebEngineView>

YoutubeAPI::YoutubeAPI(QWidget *parent) : QObject(parent)
{
    networkManager = new QNetworkAccessManager(this);
    apiKey = "AIzaSyDTDR7WTqrAI7yXSNYwyCWoKOTYcyBbeNA";

    connect(networkManager, &QNetworkAccessManager::finished,
            this, &YoutubeAPI::onVideoDataReceived);
//    request();
//    m_view->setGeometry(0, 0, 1024, 750);

}

void YoutubeAPI::requestVideo(const QString &keyword)
{
//    keyword = "해쭈";
//
//    QString Query1 = "https://www.googleapis.com/youtube/v3/search?part=id&q=";
//    QString Query2 = "&maxResults=1&type=video&fields=items&order=relevance&key=";
//    final_query = "https://www.googleapis.com/youtube/v3/search?part=id&q=%1&maxResults=1&type=video&fields=items&order=relevance&key=%2"

    QString requestUrl = QString("https://www.googleapis.com/youtube/v3/search?part=id&q=%1&maxResults=1&type=video&fields=items&order=relevance&key=%2").arg(keyword, apiKey);
    networkManager->get(QNetworkRequest(QUrl(requestUrl)));
    qDebug() << requestUrl;
}

void YoutubeAPI::onVideoDataReceived(QNetworkReply *reply)
{
    if (reply->error() == QNetworkReply::NoError) {

        QJsonObject videoinfo = QJsonDocument::fromJson(reply->readAll()).object();
        QJsonArray items = videoinfo["items"].toArray();
        QJsonObject detail = items.at(0).toObject();
        QJsonObject id = detail["id"].toObject();

        QString video_id = id.value("videoId").toString();
        QString youtube_url = "https://www.youtube-nocookie.com/embed/";

        final_url = youtube_url + video_id;

        emit urlUpdated();

    }
}

QString YoutubeAPI::url_youtube() const {
    return final_url;
}
