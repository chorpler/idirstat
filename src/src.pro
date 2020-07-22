# qmake .pro file for idirstat/src
#
# Go to the project toplevel dir and build all Makefiles:
#
#     qmake
#
# Then build with
#
#     make
#
# TEMPLATE = subdirs
# CONFIG  += ordered
# 
# SUBDIRS  = src scripts doc doc/stats man
# 
# macx {
#     # FIXME: Prevent build failure because of missing main() (issue #131)
#     # This is a pretty radical approach, and you won't get any of the scripts
#     # or any of the documentation on MacOS X; but it works.
#     #
#     # If anybody with good MacOS X know-how has a better idea that is still
#     # robust enough to prevent that same build failure to reappear, please open
#     # a pull request.
# 
#     SUBDIRS = src
# }


TEMPLATE	 = app

QT		+= widgets
CONFIG		+= release
DEPENDPATH	+= .
MOC_DIR		 = .moc
OBJECTS_DIR	 = .obj
LIBS		+= -lz


major_is_less_5 = $$find(QT_MAJOR_VERSION, [234])
!isEmpty(major_is_less_5):DEFINES += 'Q_DECL_OVERRIDE=""'


TARGET		 = idirstat
TARGET.files	 = ../idirstat
TARGET.path	 = /usr/bin
INSTALLS	+= TARGET desktop icons


SOURCES	  = main.cpp			\
	    ActionManager.cpp		\
            BucketsTableModel.cpp       \
	    Cleanup.cpp			\
	    CleanupCollection.cpp	\
	    CleanupConfigPage.cpp	\
	    ConfigDialog.cpp		\
	    DataColumns.cpp		\
	    DebugHelpers.cpp		\
            DelayedRebuilder.cpp        \
	    DirInfo.cpp			\
	    DirReadJob.cpp		\
	    DirSaver.cpp		\
	    DirTree.cpp			\
	    DirTreeCache.cpp		\
	    DirTreeModel.cpp		\
	    DirTreeView.cpp		\
	    Exception.cpp		\
	    ExcludeRulesConfigPage.cpp	\
	    ExcludeRules.cpp		\
	    FileInfo.cpp		\
	    FileInfoIterator.cpp	\
	    FileInfoSet.cpp		\
	    FileInfoSorter.cpp		\
	    FileSizeStats.cpp		\
	    FileSizeStatsWindow.cpp	\
	    FileTypeStats.cpp		\
	    FileTypeStatsWindow.cpp	\
	    HeaderTweaker.cpp		\
	    HistogramView.cpp		\
	    HistogramDraw.cpp	        \
	    HistogramItems.cpp	        \
            HistogramOverflowPanel.cpp  \
	    ListEditor.cpp		\
	    LocateFilesWindow.cpp	\
	    Logger.cpp			\
	    MainWindow.cpp		\
	    MimeCategorizer.cpp		\
	    MimeCategory.cpp		\
	    MimeCategoryConfigPage.cpp	\
	    MountPoints.cpp		\
	    OutputWindow.cpp		\
	    PercentBar.cpp		\
	    Process.cpp			\
	    Refresher.cpp		\
	    SelectionModel.cpp		\
	    Settings.cpp		\
	    SettingsHelpers.cpp		\
	    StdCleanup.cpp		\
            Subtree.cpp                 \
	    Trash.cpp			\
	    TreemapTile.cpp		\
	    TreemapView.cpp		\


HEADERS	  =				\
	    ActionManager.h		\
            BucketsTableModel.h         \
	    Cleanup.h			\
	    CleanupCollection.h		\
	    CleanupConfigPage.h		\
	    ConfigDialog.h		\
	    DataColumns.h		\
	    DebugHelpers.h		\
            DelayedRebuilder.h          \
	    DirInfo.h			\
	    DirReadJob.h		\
	    DirSaver.h			\
	    DirTree.h			\
	    DirTreeCache.h		\
	    DirTreeModel.h		\
	    DirTreeView.h		\
	    Exception.h			\
	    ExcludeRules.h		\
	    ExcludeRulesConfigPage.h	\
	    FileInfo.h			\
	    FileInfoIterator.h		\
	    FileInfoSet.h		\
	    FileInfoSorter.h		\
	    FileSizeStats.h		\
	    FileSizeStatsWindow.h	\
	    FileTypeStats.h		\
	    FileTypeStatsWindow.h	\
	    HeaderTweaker.h		\
	    HistogramView.h		\
	    HistogramItems.h		\
	    ListEditor.h		\
	    ListMover.h			\
	    LocateFilesWindow.h		\
	    Logger.h			\
	    MainWindow.h		\
	    MimeCategorizer.h		\
	    MimeCategory.h		\
	    MimeCategoryConfigPage.h	\
	    MountPoints.h		\
	    OutputWindow.h		\
	    PercentBar.h		\
	    Process.h			\
            Qt4Compat.h                 \
	    Refresher.h			\
	    SelectionModel.h		\
	    Settings.h			\
	    SettingsHelpers.h		\
	    SignalBlocker.h		\
	    StdCleanup.h		\
            Subtree.h                   \
	    Trash.h			\
	    TreemapTile.h		\
	    TreemapView.h		\
	    Version.h			\



FORMS	  = main-window.ui		   \
	    output-window.ui		   \
	    config-dialog.ui		   \
	    cleanup-config-page.ui	   \
	    mime-category-config-page.ui   \
	    exclude-rules-config-page.ui   \
	    file-size-stats-window.ui	   \
	    file-type-stats-window.ui	   \
	    locate-files-window.ui

#	    general-config-page.ui


RESOURCES = icons.qrc

desktop.files = *.desktop
desktop.path  = /usr/share/applications

icons.files   = icons/windirstat.png
icons.path    = /usr/share/icons/hicolor/32x32/apps

mac:ICON      = icons/windirstat.icns
