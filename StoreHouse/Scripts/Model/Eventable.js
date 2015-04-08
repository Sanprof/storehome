function Eventable() {
    var self = this;
    self.events = ko.observableArray();

    self.eventFire = function (eventName, args) {
        var caller = eventName ? eventName : arguments.callee.caller.name;
        var eventItem = ko.utils.arrayFirst(self.events(), function (item) {
            return item.eventName().toLowerCase() === caller.toLowerCase();
        });
        if (eventItem) {
            var arr = ko.unwrap(eventItem.eventHandlers);
            for (var i = 0; i < arr.length; i++) {
                if (typeof arr[i] == 'function') {
                    arr[i](args);
                }
            }
        }
    };

    self.subscribe = function (eventName, eventHandler) {
        var eventItem = ko.utils.arrayFirst(self.events(), function (item) {
            return item.eventName().toLowerCase() === eventName.toLowerCase();
        });
        if (eventItem) {
            eventItem.eventHandlers().push(eventHandler);
        } else {
            self.events().push(new EventItem(eventName, eventHandler));
        }
    }

    self.unsubscribe = function (eventName, eventHandler) {
        var eventItem = ko.utils.arrayFirst(self.events(), function (item) {
            var arr = ko.unwrap(item.eventHandlers);
            var eHandler = ko.utils.arrayFirst(arr, function (eh) {
                return eh === eventHandler;
            });
            arr.splice(arr.indexOf(eHandler));
            return item.eventName().toLowerCase() === eventName.toLowerCase() && arr.length == 0;
        });
        self.events.remove(eventItem);
    }
}