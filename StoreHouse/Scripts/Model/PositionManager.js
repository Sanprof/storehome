window["PositionManager"] = function PositionManager() {
    var self = this;

    Manager.call(self);
    PartialListManager.call(self);

    self.headerName("Должности");
    self.iconCSS("fa-street-view");
    self.templateName = 'positions';
    self.rootApi('positions');
    self.rootApiClass('Position');
    self.sortField('name');

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
        var position = new Position({ name: '', description: '' });
        self.editClick(position);
    };

    self.editClick = function (item) {
        item.startEdit();
        self.selectedItem(item);
        self.showDialog(true);
    };

    self.onDeletePosition = function (item) {
        confirmation.confirm(confirmationJournal.delete_position,
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
                               alertList.add(alertStatuses.success, messageJournal.position_was_deleted, [obj.name()]);
                           }
                       });
               },
               null,
               confirmBtn["delete"]);
    };
}