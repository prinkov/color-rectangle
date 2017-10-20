#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qmlRegisterSingletonType(QUrl("qrc:/Settings.qml"), "xyz.prinkov", 1, 0, "Settings");
    qmlRegisterSingletonType(QUrl("qrc:/Workspace.qml"), "xyz.prinkov", 1, 0, "Workspace");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
