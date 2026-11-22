import QtQuick
import Qt.labs.folderlistmodel
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

ShellRoot {
    id: root

    readonly property string wallDir: "file:///home/asdq/Pictures/wallpapers"
    readonly property string rawWallDir: "/home/asdq/Pictures/wallpapers"

    PanelWindow {
        id: panel
        anchors {
            bottom: true
            left: true
            right: true
        }
        implicitHeight: 360
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

        FolderListModel {
            id: folderModel
            folder: root.wallDir
            nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp"]
            showDirs: false
            sortField: FolderListModel.Name
        }

        Process {
            id: applyProc
            onExited: Qt.quit()
        }

        function applyByIndex(idx) {
            var name = folderModel.get(idx, "fileName")
            if (!name) return
            var fullPath = root.rawWallDir + "/" + name
            applyProc.command = ["noctalia", "msg", "wallpaper-set", fullPath]
            applyProc.running = true
        }

        MouseArea {
            anchors.fill: parent
            z: 0
            onClicked: Qt.quit()
        }

        Rectangle {
            id: dock
            z: 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 18
            width: Math.min(parent.width - 80, 1280)
            height: 310
            radius: 26
            color: "#dd181825"
            border.color: "#5589b4fa"
            border.width: 1

            MouseArea {
                anchors.fill: parent
                onWheel: (wheel) => {
                    if (wheel.angleDelta.y > 0) wheelView.decrementCurrentIndex()
                    else wheelView.incrementCurrentIndex()
                }
            }

            PathView {
                id: wheelView
                anchors.fill: parent
                anchors.margins: 10
                model: folderModel
                pathItemCount: 7
                preferredHighlightBegin: 0.5
                preferredHighlightEnd: 0.5
                highlightRangeMode: PathView.StrictlyEnforceRange
                dragMargin: 120
                focus: true

                Keys.onLeftPressed: decrementCurrentIndex()
                Keys.onRightPressed: incrementCurrentIndex()
                Keys.onEscapePressed: Qt.quit()
                Keys.onReturnPressed: panel.applyByIndex(wheelView.currentIndex)
                Keys.onEnterPressed: panel.applyByIndex(wheelView.currentIndex)

                path: Path {
                    startX: 60; startY: 235
                    PathAttribute { name: "itemScale"; value: 0.62 }
                    PathAttribute { name: "itemAngle"; value: -24 }
                    PathAttribute { name: "itemOpacity"; value: 0.45 }
                    PathAttribute { name: "itemZ"; value: 1 }

                    PathQuad {
                        x: wheelView.width / 2; y: 145
                        controlX: wheelView.width * 0.25; controlY: 155
                    }
                    PathAttribute { name: "itemScale"; value: 1.15 }
                    PathAttribute { name: "itemAngle"; value: 0 }
                    PathAttribute { name: "itemOpacity"; value: 1.0 }
                    PathAttribute { name: "itemZ"; value: 10 }

                    PathQuad {
                        x: wheelView.width - 60; y: 235
                        controlX: wheelView.width * 0.75; controlY: 155
                    }
                    PathAttribute { name: "itemScale"; value: 0.62 }
                    PathAttribute { name: "itemAngle"; value: 24 }
                    PathAttribute { name: "itemOpacity"; value: 0.45 }
                    PathAttribute { name: "itemZ"; value: 1 }
                }

                delegate: Item {
                    id: card
                    readonly property bool isCurrent: PathView.isCurrentItem

                    width: 240
                    height: 150
                    scale: PathView.itemScale ?? 1.0
                    opacity: PathView.itemOpacity ?? 1.0
                    z: PathView.itemZ ?? 1

                    transform: Rotation {
                        origin.x: card.width / 2
                        origin.y: card.height / 2
                        angle: card.PathView.itemAngle ?? 0
                    }

                    Rectangle {
                        anchors.fill: parent
                        radius: 14
                        color: "#1e1e2e"
                        border.width: card.isCurrent ? 3 : 1
                        border.color: card.isCurrent ? "#89b4fa" : "#45475a"
                        clip: true

                        Image {
                            anchors.fill: parent
                            anchors.margins: card.isCurrent ? 3 : 1
                            source: fileUrl
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                            sourceSize.width: 480
                            sourceSize.height: 300
                        }
                    }

                    Text {
                        visible: card.isCurrent
                        anchors.top: parent.bottom
                        anchors.topMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: fileBaseName
                        color: "#cdd6f4"
                        font.pixelSize: 13
                        font.bold: true
                        elide: Text.ElideMiddle
                        width: 260
                        horizontalAlignment: Text.AlignHCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (card.isCurrent) {
                                panel.applyByIndex(index)
                            } else {
                                wheelView.currentIndex = index
                            }
                        }
                    }
                }
            }
        }
    }
}
