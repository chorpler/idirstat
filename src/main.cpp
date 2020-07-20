/*
 *   File name: main.cpp
 *   Summary:	iDirStat main program
 *   License:	GPL V2 - See file LICENSE for details.
 *
 *   Author:	Stefan Hundhammer <Stefan.Hundhammer@gmx.de>
 */


#include <unistd.h>	// getuid()
#include <sys/types.h>	// uid_t
#include <iostream>	// cerr

#include <QApplication>
#include "MainWindow.h"
#include "DirTreeModel.h"
#include "Logger.h"

using std::cerr;
static const char * progName = "idirstat";
static bool fatal = false;


void usage( const QStringList & argList )
{
    cerr << "\n"
	 << "Usage: \n"
	 << "\n"
	 << "  " << progName << " [--slow-update|-s] [<directory-name>]\n"
	 << "  " << progName << " --cache|-c <cache-file-name>\n"
	 << "  " << progName << " --help|-h\n"
	 << std::endl;

    logError() << "FATAL: Bad command line args: " << argList.join( " " ) << endl;
    // Simply exit(1) here results in a segfault (?).
    fatal = true;
}


/**
 * Extract a command line switch (a command line argument without any
 * additional parameter) from the command line and remove it from 'argList'.
 **/
bool commandLineSwitch( const QString & longName,
			const QString & shortName,
			QStringList   & argList )
{
    if ( argList.contains( longName  ) ||
	 argList.contains( shortName )	 )
    {
	argList.removeAll( longName  );
	argList.removeAll( shortName );
        logDebug() << "Found " << longName << endl;
	return true;
    }
    else
    {
        // logDebug() << "No " << longName << endl;
	return false;
    }
}

int launchNewApp(int argc, char *argv[]) {
    Logger logger( "/tmp/idirstat-$USER", "idirstat.log" );

    // Set org/app name for QSettings
    QCoreApplication::setOrganizationName( "iDirStat" );
    QCoreApplication::setApplicationName ( "iDirStat" );

    QApplication app( argc, argv);
    QStringList argList = QCoreApplication::arguments();
    argList.removeFirst(); // Remove program name

    MainWindow mainWin;
    mainWin.show();

    if ( commandLineSwitch( "--slow-update", "-s", argList ) )
    mainWin.dirTreeModel()->setSlowUpdate();

    if ( argList.isEmpty() )
    mainWin.askOpenUrl();
    else
    {
    QString arg = argList.first();

    if ( arg == "--cache" || arg == "-c" )
    {
        if ( argList.size() == 2 )
        {
        QString cacheFileName = argList.at(1);
        logDebug() << "Reading cache file " << cacheFileName << endl;
        mainWin.readCache( cacheFileName );
        }
        else
        usage( argList );
    }
    else if ( arg == "--help" || arg == "-h" )
        usage( argList );
    else if ( arg.startsWith( "-" ) || argList.size() > 1 )
        usage( argList );
    else if ( ! arg.isEmpty() )
    {
        mainWin.openUrl( arg );
    }
    }

    if ( ! fatal )
    app.exec();

    return fatal ? 1 : 0;
}

int main( int argc, char *argv[] )
{
//    Logger logger( "/tmp/idirstat-$USER", "idirstat.log" );

//    // Set org/app name for QSettings
//    QCoreApplication::setOrganizationName( "iDirStat" );
//    QCoreApplication::setApplicationName ( "iDirStat" );

//    QApplication app( argc, argv);
//    QStringList argList = QCoreApplication::arguments();
//    argList.removeFirst(); // Remove program name

//    MainWindow mainWin;
//    mainWin.show();

//    if ( commandLineSwitch( "--slow-update", "-s", argList ) )
//	mainWin.dirTreeModel()->setSlowUpdate();

//    if ( argList.isEmpty() )
//	mainWin.askOpenUrl();
//    else
//    {
//	QString arg = argList.first();

//	if ( arg == "--cache" || arg == "-c" )
//	{
//	    if ( argList.size() == 2 )
//	    {
//		QString cacheFileName = argList.at(1);
//		logDebug() << "Reading cache file " << cacheFileName << endl;
//		mainWin.readCache( cacheFileName );
//	    }
//	    else
//		usage( argList );
//	}
//	else if ( arg == "--help" || arg == "-h" )
//	    usage( argList );
//	else if ( arg.startsWith( "-" ) || argList.size() > 1 )
//	    usage( argList );
//	else if ( ! arg.isEmpty() )
//	{
//	    mainWin.openUrl( arg );
//	}
//    }

//    if ( ! fatal )
//	app.exec();

//    return fatal ? 1 : 0;
    return launchNewApp(argc, argv);
}
