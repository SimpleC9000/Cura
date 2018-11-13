import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4

import UM 1.3 as UM
import Cura 1.1 as Cura


Item
{
    id: prepareMenu
    // This widget doesn't show tooltips by itself. Instead it emits signals so others can do something with it.
    signal showTooltip(Item item, point location, string text)
    signal hideTooltip()

    UM.I18nCatalog
    {
        id: catalog
        name: "cura"
    }

    // Item to ensure that all of the buttons are nicely centered.
    Item
    {
        anchors.horizontalCenter: parent.horizontalCenter
        width: openFileButton.width + itemRowBackground.width
        height: parent.height

        Button
        {
            id: openFileButton
            text: catalog.i18nc("@action:button", "Open File")
            iconSource: UM.Theme.getIcon("load")
            style: UM.Theme.styles.tool_button
            tooltip: ""
            action: Cura.Actions.open
        }

        Rectangle
        {
            id: itemRowBackground
            radius: UM.Theme.getSize("default_radius").width

            color: UM.Theme.getColor("toolbar_background")

            width: itemRow.width + UM.Theme.getSize("default_margin").width
            height: parent.height

            anchors.left: openFileButton.right
            anchors.leftMargin: UM.Theme.getSize("default_margin").width

            RowLayout
            {
                id: itemRow

                anchors.centerIn: parent

                width: 0.9 * prepareMenu.width
                height: parent.height

                Cura.MachineSelector
                {
                    id: machineSelection
                    z: openFileButton.z - 1

                    Layout.minimumWidth: 240
                    Layout.maximumWidth: 240
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                // Separator line
                Rectangle
                {
                    height: parent.height
                    width: UM.Theme.getSize("default_lining").width
                    color: UM.Theme.getColor("lining")
                }

                Cura.QuickConfigurationSelector
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: itemRow.width - machineSelection.width - printSetupSelector.width - 2 * UM.Theme.getSize("default_lining").width
                }

                // Separator line
                Rectangle
                {
                    height: parent.height
                    width: UM.Theme.getSize("default_lining").width
                    color: UM.Theme.getColor("lining")
                }

                Cura.PrintSetupSelector
                {
                    id: printSetupSelector

                    onShowTooltip: prepareMenu.showTooltip(item, location, text)
                    onHideTooltip: prepareMenu.hideTooltip()

                    Layout.minimumWidth: 460
                    Layout.maximumWidth: 460
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }
    }
}