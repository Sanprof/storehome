window["StartPageItem"] = function StartPageItem(data) {
    var self = this;
    BaseObject.call(self);

    self.name = ko.observable();
    self.count = ko.observable();
    self.isinc = ko.observable();
    self.time = ko.observable();
    self.worker = ko.observable();

    if (data) {
        self.init(data);
        if (data.worker) {
            self.worker(new Worker(data.worker));
        }
    }

    self.localTime = ko.computed(function () {
        if (self.time()) {
            return self.time().parseUTC().slicFormatWithTime();
        }
    });
}