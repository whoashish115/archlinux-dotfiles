import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Io
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
    id: root
    property bool pinned: Config.options?.dock.pinnedOnStartup ?? false

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: dockRoot
            required property var modelData
            screen: modelData
            visible: !GlobalStates.screenLocked

            property bool reveal: root.pinned || (Config.options?.dock.hoverToReveal && dockMouseArea.containsMouse) || dockApps.requestDockShow || (!ToplevelManager.activeToplevel?.activated)

            anchors {
                bottom: true
                left: true
                right: true
            }

            exclusiveZone: root.pinned ? implicitHeight - (Appearance.sizes.hyprlandGapsOut) - (Appearance.sizes.elevationMargin - Appearance.sizes.hyprlandGapsOut) : 0

            implicitHeight: (Config.options?.dock.height ?? 70) + Appearance.sizes.elevationMargin + Appearance.sizes.hyprlandGapsOut
            WlrLayershell.namespace: "quickshell:dock"
            color: "transparent"

            mask: Region {
                item: dockMouseArea
            }

            MouseArea {
                id: dockMouseArea
                height: parent.height
                anchors {
                    top: parent.top
                    topMargin: dockRoot.reveal ? 0 : Config.options?.dock.hoverToReveal ? (dockRoot.implicitHeight - Config.options.dock.hoverRegionHeight) : (dockRoot.implicitHeight + 1)
                    left: parent.left
                    right: parent.right
                }
                hoverEnabled: true

                Behavior on anchors.topMargin {
                    animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
                }

                Item {
                    id: dockHoverRegion
                    anchors.fill: parent

                    Item {
                        id: dockBackground
                        anchors.fill: parent
                        anchors.margins: Appearance.sizes.elevationMargin  // uniform margin

                        StyledRectangularShadow {
                            target: dockVisualBackground
                        }

                        Rectangle {
                            id: dockVisualBackground
                            anchors.fill: parent
                            color: Appearance.colors.colLayer0
                            border.width: 1
                            border.color: Appearance.colors.colLayer0Border
                            radius: Appearance.rounding.large
                        }

                        RowLayout {
                            id: dockRow
                            anchors.fill: parent
                            spacing: 4
                            property real padding: -8
                            // ---------- FIX: vertical alignment center ----------
                            Layout.alignment: Qt.AlignVCenter
                            // ---------------------------------------------------

                            VerticalButtonGroup {
                                Layout.margins: 8
                                Layout.alignment: Qt.AlignVCenter      // vertical center
                                GroupButton {
                                    baseWidth: 35
                                    baseHeight: 35
                                    clickedWidth: baseWidth
                                    clickedHeight: baseHeight + 20
                                    buttonRadius: Appearance.rounding.normal
                                    toggled: root.pinned
                                    onClicked: root.pinned = !root.pinned
                                    contentItem: MaterialSymbol {
                                        anchors.centerIn: parent      // <- center icon
                                        text: "keep"
                                        
                                        horizontalAlignment: Text.AlignHCenter
                                        iconSize: Appearance.font.pixelSize.larger
                                        color: root.pinned ? Appearance.m3colors.m3onPrimary : Appearance.colors.colOnLayer0
                                    }
                                }
                            }

                          DockSeparator {
 Layout.alignment: Qt.AlignVCenter 
 Layout.topMargin: 16
    				Layout.bottomMargin: 16
}


// ---------- Scrollable DockApps ----------
Flickable {
    id: dockAppsFlick
    contentWidth: dockAppsRow.implicitWidth
    interactive: true
    clip: true
    Layout.fillWidth: true
    Layout.fillHeight: true
    	Layout.topMargin: -8
    RowLayout {
        id: dockAppsRow
        anchors.fill: parent
        spacing: dockRow.spacing
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignVCenter
         // CALCULATED TOP MARGIN
 

        Item {
            Layout.fillHeight: true
            Layout.preferredWidth: dockApps.implicitWidth
            anchors.verticalCenter: parent.verticalCenter

            DockApps {
                id: dockApps
                Layout.fillHeight: true
            }
        }
    }
}

                            // -----------------------------------------

                            DockSeparator {
 Layout.alignment: Qt.AlignVCenter 
 Layout.topMargin: 16
    				Layout.bottomMargin: 16
}

                            DockButton {
                            
                                Layout.fillHeight: true
                                Layout.alignment: Qt.AlignVCenter   // vertical center
                                onClicked: GlobalStates.overviewOpen = !GlobalStates.overviewOpen
                                 Layout.topMargin: 8
    				Layout.bottomMargin: 8
    				 Layout.leftMargin: 8
    				Layout.rightMargin: 8
                                contentItem: MaterialSymbol {
                                    anchors.centerIn: parent      // <- center icon
                                    horizontalAlignment: Text.AlignHCenter
                                    font.pixelSize: parent.width / 2
                                    text: "apps"
                                    color: Appearance.colors.colOnLayer0
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


