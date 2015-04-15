window["Tool"] = function Tool(data) {
    var self = this;
    BaseObject.call(self);
    Newable.call(self);

    self.name = ko.observable();
    self.toolscount = ko.observable();
    self.toolsinuse = ko.observable();
    self.toolstoadd = ko.observable();
    self.cell = ko.observable();
    self.min = ko.observable();
    self.max = ko.observable();

    self.freeTools = ko.computed(function () {
        return self.toolscount() - self.toolsinuse();
    })

    if (data) {
        self.init(data);
    }

    self.canIncoming = ko.computed(function () {
        return self.toolsinuse() > 0;
    });

    self.canIssuing = ko.computed(function () {
        return self.toolscount() - self.toolsinuse() > 0;
    });

    self.startEdit = function () {
        self.name_edit = ko.observable(ko.unwrap(self.name)).extend({ required: "Название обязательно" });
        self.name_edit.hasError(false);
        self.count_edit = ko.observable(self.isNew() ? 1 : 0).extend({ required: "Количество обязательно" });
        self.count_edit.hasError(false);
        self.cell_edit = ko.observable(ko.unwrap(self.cell)).extend({ minMax: { min: self.min(), max: self.max() } });
        self.cell_edit.hasError(false);
    };

    self.endEdit = function () {
        self.name(ko.unwrap(self.name_edit));
        self.cell(ko.unwrap(self.cell_edit));
        if (self.isNew()) {
            self.toolscount(ko.unwrap(self.count_edit));
        } else {
            self.toolstoadd(ko.unwrap(self.count_edit));
        }
    };

    self.editClick = function (item) {
        item.startEdit();
        self.selectedItem(item);
        self.showDialog(true);
    };

    self.toJSON = function () {
        var json = {
            name: self.name(),
            cell: self.cell(),
            count: self.isNew() ? parseInt(self.toolscount()) : parseInt(self.toolstoadd())
        };
        if (!self.isNew()) {
            json.id = self.id();
        }
        return json;
    };
}