window["Account"] = function Account(data) {
    var self = this;
    BaseObject.call(self);
    Newable.call(self);
    self.username = ko.observable();
    self.email = ko.observable();
    self.typeid = ko.observable();
    self.type = ko.observable();
    self.workerid = ko.observable();
    self.creationdate = ko.observable();

    self.worker = ko.observable();

    if (data) {
        self.init(data);
        self.worker(new Worker(data.worker));
        self.workerid(data.worker.id);
        self.type(data.type.name);
        self.typeid(data.type.id);
    }

    self.startEdit = function (item) {
        item.username_edit = ko.observable(ko.unwrap(item.username)).extend({ required: "Имя учетной записи обязательно" });
        item.username_edit.hasError(false);
        item.disabled = ko.unwrap(item.username) != null ? 'disabled' : undefined;
        item.email_edit = ko.observable(ko.unwrap(item.email)).extend({ required: "Email обязательно" });
        item.email_edit.hasError(false);
        item.type_edit = ko.observable(ko.unwrap(item.type));
        item.typeid_edit = ko.observable(ko.unwrap(item.typeid)).extend({ required: "Тип обязательно" });
        item.typeid_edit.hasError(false);
        item.worker_edit = {
            visible: ko.unwrap(item.username) == null,
            value: ko.observable(ko.unwrap(item.worker.fullName))
        }
        item.workerid_edit = ko.observable(ko.unwrap(item.workerid)).extend({ required: "Работник обязательно" });
        item.workerid_edit.hasError(false);
    };

    self.localTime = ko.computed(function () {
        if (self.creationdate()) {
            return self.creationdate().parseUTC().slicFormatWithTime();
        }
    });

    self.endEdit = function () {
        self.username(ko.unwrap(self.username_edit));
        self.email(ko.unwrap(self.email_edit));
        self.typeid(ko.unwrap(self.typeid_edit));
        self.workerid(ko.unwrap(self.workerid_edit));
    }

    self.onChangeType = function (data, type) {
        data.type_edit(type.name);
        data.typeid_edit(type.id);
    };

    self.selectWorker = function (obj, worker) {
        obj.worker_edit.value(worker.name);
        obj.workerid_edit(worker.id);
    };

    self.toJSON = function () {
        var json = {
            typeid: ko.unwrap(self.typeid),
            email: ko.unwrap(self.email),
        }
        if (self.isNew()) {
            json.username = ko.unwrap(self.username);
            json.workerid = ko.unwrap(self.workerid);
        } else {
            json.id = ko.unwrap(self.id);
        }
        return json;
    }
}