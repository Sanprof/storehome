window["WorkerManager"] = function WorkerManager() {
    var self = this;
    Manager.call(self);
    PartialListManager.call(self);

    self.headerName("Работники");
    self.iconCSS("fa-users");
    self.rootApi('workers');
    self.rootApiClass("Worker");
    self.sortField('lastname');
    self.templateName = 'workers';
    self.positions = ko.observableArray();

    self.onApplyDialog = function (data) {
        data = data.object;
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
    };

    self.addNewClick = function () {
        var worker = new Worker({ lastname: '', firstname: '', middlename: '' });
        self.editClick(worker);
    };

    self.editClick = function (item) {
        call_ajax_to_service(
            'positions',
            "GET",
            null,
            null,
            function (callBackData, method, responseData) {
                if (responseData.status.Code == 0) {
                    self.positions(ko.utils.arrayMap(responseData.response.data, function (item) {
                        return { id: item.id, name: item.name };
                    }));
                    item.startEdit();
                    self.selectedItem(item);
                    self.showDialog(true);
                }
            });
    };

    self.onDeleteWorker = function (item) {
        confirmation.confirm(confirmationJournal.delete_worker,
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
                               alertList.add(alertStatuses.success, messageJournal.worker_was_deleted, [obj.name()]);
                           }
                       });
               },
               null,
               confirmBtn["delete"]);
    };
}