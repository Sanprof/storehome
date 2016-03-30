window["WorkerManager"] = function WorkerManager() {
    var self = this;
    Manager.call(self);
    PartialListManager.call(self);

    self.headerName("Работники");
    self.iconCSS("fa-users");
    self.rootApi('workers');
    self.rootApiClass("Worker");
    self.sortField('lastname');
    self.templateName('workers');
    self.positions = ko.observableArray();

    self.showIssueDialog = ko.observable(false);
    self.issueItem = ko.observable();

    self.showInfoDialog = ko.observable(false);
    self.infoItem = ko.observable();
    self.needReloadInfo = ko.observable(false);

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

    self.onIssueTool = function (item) {
        call_ajax_to_service(
                'workers',
                "GET",
                null,
                null,
                function (callBackData, method, responseData) {
                    if (responseData.status.Code == 0) {
                        var obj = {
                            id: ko.unwrap(item.id),
                            name: ko.unwrap(item.name),
                            worker_edit: ko.observable().extend({ required: "Работник обязательно" }),
                            count_edit: ko.observable(1).extend({ required: "Количество обязательно" })
                        };
                        if (item.worker) {
                            obj.worker_edit(item.worker.fullName());
                        } else {
                            obj.worker_edit.hasError(false);
                        }
                        self.issueItem(obj);
                        self.showIssueDialog(true);
                        self.allWorkers(ko.utils.arrayMap(responseData.response.data, function (item) {
                            return { id: item.id, name: item.lastname + ' ' + item.firstname + ' ' + item.middlename }
                        }));
                    }
                });
    };

    self.onIssueCancelDialog = function () {
        self.onCancelDialog();
        self.showIssueDialog(false);
        self.issueItem(null);
    };

    self.onIssueApplyDialog = function (data) {
        data = data.object;
        var item = 'count_edit';
        if (item in self && 'hasError' in self[item]) {
            self[item].valueHasMutated();
            if (self[item].hasError()) {
                return;
            }
        }
        var worker = ko.utils.arrayFirst(self.allWorkers(), function (item) {
            return item.name == ko.unwrap(data.worker_edit);
        });
        if (worker) {
            self.applyIncIssue(
                ko.unwrap(data.id),
                ko.unwrap(data.count_edit),
                ko.unwrap(worker.id),
                false,
                function (callBackData, method, responseData) {
                    if (responseData.status.Code == 0) {
                        ko.utils.arrayForEach(self.rootApiItems(), function (item) {
                            if (item.id() == callBackData) {
                                item.toolsinuse(responseData.response);
                            }
                        });
                        self.onIssueCancelDialog();
                    }
                });
        }
    };

    self.userInfoClick = function (item) {
        call_ajax_to_service(
            self.rootApi() + '/used',
            "POST",
            { id: ko.unwrap(item.id) },
            null,
            function (callBackData, method, responseData) {
                if (responseData.status.Code == 0) {
                    self.infoItem({
                        items: ko.observableArray(ko.utils.arrayMap(responseData.response, function (item) {
                            function EditingObject() {
                                var self = this;
                                self.workerid = item.id;
                                self.id = item.tool.id;
                                self.name = item.tool.name;
                                self.count = ko.observable(item.count);
                                self.valueToIncoming = ko.observable(1);
                                self.canApply = ko.computed(function () {
                                    return self.valueToIncoming() > 0 && self.valueToIncoming() <= ko.unwrap(self.count);
                                });
                            }
                            return new EditingObject();
                        })),
                        workername: ko.utils.arrayFirst(self.rootApiItems(), function (item) {
                            return ko.unwrap(item.id) == responseData.response[0].id;
                        }).fullName()
                    });
                    self.showInfoDialog(true);
                }
            });
    };

    self.onInfoCancelDialog = function () {
        self.onCancelDialog();
        if (self.needReloadInfo() == true) {
            self.loadPartialData();
            self.needReloadInfo(false);
        }
        self.showInfoDialog(false);
        self.infoItem(null);
    };

    self.applyIncIssue = function (toolID, count, workerID, isincoming, onSuccess) {
        call_ajax_to_service(
                'tools/incat/incissue',
                "POST",
                { id: toolID, count: count, isinc: isincoming, workerid: workerID },
                toolID,
                onSuccess);
    }

    self.onIncomingClick = function (item) {
        self.needReloadInfo(true);
        self.applyIncIssue(
            ko.unwrap(item.id),
            ko.unwrap(item.valueToIncoming),
            ko.unwrap(item.workerid),
            true,
            function (callBackData, method, responseData) {
                if (responseData.status.Code == 0) {
                    var tool = ko.utils.arrayFirst(ko.unwrap(self.infoItem().items), function (elem) {
                        return ko.unwrap(elem.id) == ko.unwrap(item.id);
                    });
                    if (tool) {
                        tool.count(ko.unwrap(tool.count) - ko.unwrap(item.valueToIncoming));
                        if (tool.count() > 0) {
                            tool.valueToIncoming(1);
                        } else {
                            self.infoItem().items.remove(tool);
                        }
                        if (ko.unwrap(self.infoItem().items).length == 0) {
                            self.onInfoCancelDialog();
                        }
                    }
                }
            });
    };
}