function Newable() {
    var self = this;

    self.id = ko.observable();
    self.isNew = ko.computed(function () {
        var id = ko.unwrap(self.id);
        return id == null || (id && id <= 0);
    });
}