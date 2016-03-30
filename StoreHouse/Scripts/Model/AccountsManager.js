window["AccountsManager"] = function AccountsManager(parent) {
    var self = this
    Manager.call(self);
    PartialListManager.call(self);

    self.headerName("Учетные записи");
    self.iconCSS("fa-user-plus");
    self.rootApi('accounts');
    self.rootApiClass("Account");
    self.sortField("username");
    self.templateName('accounts');
    self.types = ko.observableArray();
    self.allWorkers = ko.observableArray();

    self.addNewClick = function () {
        var account = new Account();
        account.parent = self;
        self.editClick(account);
    };

    self.editClick = function (item) {
        call_ajax_to_service(
                'workers',
                "GET",
                null,
                null,
                function (callBackData, method, responseData) {
                    if (responseData.status.Code == 0) {
                        self.allWorkers(ko.utils.arrayMap(responseData.response.data, function (item) {
                            return { id: item.id, name: item.lastname + ' ' + item.firstname + ' ' + item.middlename }
                        }));
                        item.startEdit(item);
                        self.selectedItem(item);
                        self.showDialog(true);
                    }
                });
        item.startEdit(item);
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
                }
            });
    }

    self.onDeleteAccount = function (item) {
        confirmation.confirm(confirmationJournal.delete_account,
                item,
                function (item) {
                    call_ajax_to_service(
                        self.rootApi(),
                        "DELETE",
                        { id: item.id() },
                        item.id(),
                        function (callBackData, method, responseData) {
                            if (responseData.status.Code == 0) {
                                var obj = self.onDeleteSuccessfully(callBackData);
                                alertList.add(alertStatuses.success, messageJournal.account_deleted, [ko.unwrap(obj.username)]);
                            }
                        });
                },
                null,
                confirmBtn["delete"]);
    };

    self.loadAccountTypes = function () {
        call_ajax_to_service(
            self.rootApi() + '/types',
            "POST",
            null,
            null,
            function (callBackData, method, responseData) {
                if (responseData.status.Code == 0) {
                    self.types(ko.utils.arrayMap(responseData.response, function (item) {
                        return item;
                    }));
                }
            });
    };

    self.subscribe("dataloadedevent", self.loadAccountTypes);
}