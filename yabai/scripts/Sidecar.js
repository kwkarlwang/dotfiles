var deviceName = "Karl’s iPad";
var sys_events = Application("System Events");

var process = sys_events.processes.byName("ControlCenter");
var items = process.menuBars[0].menuBarItems;
for (var i = 0; i < items.length; i++) {
  if (items[i].name().includes("Display")) {
    var displayButton = items[i];
    break;
  }
}
// click the display button
displayButton.click();
delay(0.5);
// click iPad
process.windows[0].groups[0].scrollAreas[0].checkboxes
  .byName(deviceName)
  .click();

displayButton.click();
