/* todo fo release:
 *  raiting tables; --
 *  continue btn;
 *  add music;
 *  testing android;
 *  testing ios;
 * **swipe back
 * */

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "vibrator.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    Vibrator vibrator;
    qmlRegisterSingletonType(QUrl("qrc:/Settings.qml"), "xyz.prinkov", 1, 0, "Settings");
    qmlRegisterSingletonType(QUrl("qrc:/Workspace.qml"), "xyz.prinkov", 1, 0, "Workspace");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Vibrator", &vibrator);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
