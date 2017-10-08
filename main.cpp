#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterSingletonType(QUrl("qrc:/Workspace.qml"), "xyz.prinkov", 1, 0, "Workspace" );
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
