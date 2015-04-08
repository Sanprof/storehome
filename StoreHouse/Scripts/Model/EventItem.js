function EventItem(eventName, eventHandler) {
    this.eventName = ko.observable(eventName);
    this.eventHandlers = ko.observableArray();
    this.eventHandlers().push(eventHandler);
}