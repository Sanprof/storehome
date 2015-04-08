window["DescrName"] = function DescrName() {
    var self = this;

    BaseObject.call(self);
    Newable.call(self);

    self.name = ko.observable();
    self.description = ko.observable();

    self.startEdit = function () {
        self.name_edit = ko.observable(ko.unwrap(self.name)).extend({ required: "Название обязательно" });
        self.name_edit.hasError(false);
        self.description_edit = ko.observable(ko.unwrap(self.description)).extend({ required: "Описание обязательно" });
        self.description_edit.hasError(false);
    };

    self.endEdit = function () {
        self.name(ko.unwrap(self.name_edit));
        self.description(ko.unwrap(self.description_edit));
    };

    self.toJSON = function () {
        var obj = {
            name: self.name(),
            description: self.description()
        };
        if (!self.isNew()) {
            obj.id = self.id();
        }
        return obj;
    };
}