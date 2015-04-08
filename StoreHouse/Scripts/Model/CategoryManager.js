window["CategoryManager"] = function CategoryManager() {
    var self = this;

    Manager.call(self);
    PartialListManager.call(self);

    self.rootApi('categories');
    self.rootApiClass('Category');
    self.sortField('name');
    self.editedCategory = ko.observable();

    self.addNewClick = function () {
        var category = new Category({ name: '', description: '' });
        category.parent = self;
        self.editClick(category);
    };

    self.editClick = function (item) {
        item.startEdit();
        self.selectedItem(item);
        self.showDialog(true);
    };

    self.onApplyDialog = function (data) {
        var data = data.object;
        if (!data.IsValid(true)) {
            return;
        }
        data.endEdit();
        call_ajax_to_service(self.rootApi(),
            data.isNew() ? "PUT" : "POST",
            data.toJSON(),
            null,
            function (callBackData, method, responseData) {
                if (responseData.status.Code == 0) {
                    var obj = self.onAddUpdateSuccessfully(method, responseData.response, self.rootApiClass());
                    if (obj) {
                        obj.parent = self;
                    }
                }
            });
    }

    self.onDeleteCategory = function (item) {
        confirmation.confirm(confirmationJournal.delete_category,
                item,
                function (item) {
                    call_ajax_to_service(self.rootApi(),
                        "DELETE",
                        { id: item.id() },
                        item.id(),
                        function (callBackData, method, responseData) {
                            if (responseData.status.Code == 0) {
                                var obj = self.onDeleteSuccessfully(callBackData);
                                alertList.add(alertStatuses.success, messageJournal.category_deleted, [obj.name()]);
                            }
                        });
                },
                null,
                confirmBtn["delete"]);
    };

    self.setCategoryParent = function () {
        ko.utils.arrayForEach(self.rootApiItems(), function (item) {
            item.parent = self;
        });
    };

    self.subscribe('dataLoadedEvent', self.setCategoryParent);
}