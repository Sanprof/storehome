window["Worker"] = function Worker(data) {
    var self = this;
    BaseObject.call(self);
    Newable.call(self);

    self.lastname = ko.observable();
    self.firstname = ko.observable();
    self.middlename = ko.observable();
    self.positionid = ko.observable();
    self.position = ko.observable();
    self.toolscount = ko.observable();

    self.fullName = ko.computed(function () {
        return self.lastname() + ' ' + self.firstname() + ' ' + self.middlename();
    });

    self.shortFullName = ko.computed(function () {
        if (self.lastname() != null &&
            self.firstname() != null &&
            self.middlename() != null) {
            return self.lastname() + ' ' + self.firstname().substring(0, 1).toUpperCase() + '.' + self.middlename().substring(0, 1).toUpperCase() + '.';
        }
    });

    if (data) {
        self.init(data);
        if (data.position) {
            self.position(data.position.name);
            self.positionid(data.position.id);
        }
    }

    self.startEdit = function () {
        self.lastname_edit = ko.observable(ko.unwrap(self.lastname)).extend({ required: "Фамилия обязательно" });
        self.lastname_edit.hasError(false);
        self.firstname_edit = ko.observable(ko.unwrap(self.firstname)).extend({ required: "Имя обязательно" });
        self.firstname_edit.hasError(false);
        self.middlename_edit = ko.observable(ko.unwrap(self.middlename)).extend({ required: "Отчество обязательно" });
        self.middlename_edit.hasError(false);
        self.position_edit = ko.observable(ko.unwrap(self.position)).extend({ required: "Должность обязательно" });
        self.position_edit.hasError(false);
        self.positionid_edit = ko.observable(ko.unwrap(self.positionid));
    };

    self.endEdit = function () {
        self.lastname(ko.unwrap(self.lastname_edit));
        self.firstname(ko.unwrap(self.firstname_edit));
        self.middlename(ko.unwrap(self.middlename_edit));
        self.positionid(ko.unwrap(self.positionid_edit));
        self.position(ko.unwrap(self.position_edit));
    };

    self.onChangePosition = function (worker, position) {
        worker.positionid_edit(ko.unwrap(position.id));
        worker.position_edit(ko.unwrap(position.name));
    };

    var baseToJson = self.toJSON;
    self.toJSON = function () {
        var obj = {
            id: self.id(),
            lastname: self.lastname(),
            firstname: self.firstname(),
            middlename: self.middlename(),
            positionid: self.positionid()
        }
        return obj;
    }
}