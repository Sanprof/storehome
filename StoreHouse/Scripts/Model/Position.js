window["Position"] = function Position(data) {
    var self = this;
    DescrName.call(self);

    if (data) {
        self.init(data);
    }

    self.rootPosition = ko.computed(function () {
        return self.id() == 1;
    });
}