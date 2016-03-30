window["Audit"] = function Audit(data) {
    var self = this;
    BaseObject.call(self);

    self.id = null;
    self.action = null;
    self.count = null;
    self.readed = false;
    self.tool = null;
    self.worker = null;
    self.creationdate = null;

    if (data) {
        self.init(data);
        self.tool = new Tool(data.tool);
        self.worker = new Worker(data.worker);
    }

    self.localTime = ko.computed(function () {
        if (self.creationdate) {
            return self.creationdate.parseUTC().slicFormatWithTime();
        }
    });
}