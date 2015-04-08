window["Category"] = function Category(data) {
    var self = this;
    Manager.call(self);
    PartialListManager.call(self);
    DescrName.call(self);

    self.showWriteOffDialog = ko.observable(false);
    self.writeoffItem = ko.observable();

    self.showIncomingIssueDialog = ko.observable(false);
    self.incIssueItem = ko.observable();

    self.showInfoDialog = ko.observable(false);
    self.infoItem = ko.observable();

    self.isincoming = ko.observable(false);
    self.expanded = ko.observable(false);


    self.toolpositions = ko.observable();
    self.toolscount = ko.observable();
    self.tools = ko.observableArray();
    self.allWorkers = ko.observableArray();
    self.rootApi('tools/incat');
    self.rootApiClass('Tool');
    self.sortField('name');

    if (data) {
        self.init(data);
    }

    self.recalc = ko.computed(function () {
        if (self.rootApiItems().length > 0) {
            self.toolpositions(self.rootApiItems().length);
            var count = 0;
            ko.utils.arrayForEach(self.rootApiItems(), function (item) {
                count += item.toolscount();
            })
            self.toolscount(count);
        }
    });

    self.expandCollapse = function () {
        self.expanded(!self.expanded());
        self.extendedParams({ id: self.id() })
        if (self.expanded()) {
            self.loadPartialData();
        }
    };

    self.addToolClick = function () {
        var tool = new Tool({ name: '', toolscount: '' });
        self.editClick(tool);
    };

    self.editClick = function (item) {
        self.parent.editedCategory(self);
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
        var json = data.toJSON();
        json.category = self.id();
        call_ajax_to_service(
            self.rootApi(),
            data.isNew() ? "PUT" : "POST",
            json,
            null,
            function (callBackData, method, responseData) {
                if (responseData.status.Code == 0) {
                    var obj = self.onAddUpdateSuccessfully(method, responseData.response, self.rootApiClass());
                    if (method == "POST") {
                        var tool = ko.utils.arrayFirst(self.rootApiItems(), function (item) {
                            return item.id() == responseData.response.id;
                        });
                        if (tool) {
                            tool.init(responseData.response);
                        }
                    }
                }
            });
    }



    self.onIncommingTool = function (item) {
        self.isincoming(true);
        self.onIncIssueTool(item);
    };

    self.onIssueTool = function (item) {
        self.isincoming(false);
        self.onIncIssueTool(item);
    };

    self.onDeleteTool = function (item) {
        confirmation.confirm(confirmationJournal.delete_tool,
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
                               alertList.add(alertStatuses.success, messageJournal.tool_was_deleted, [obj.name()]);
                           }
                       });
               },
               null,
               confirmBtn["delete"]);
    };

    self.onWriteOffTool = function (item) {
        self.parent.editedCategory(self);
        self.writeoffItem({ id: item.id, name: item.name, count_edit: ko.observable(1).extend({ required: "Количество обязательно" }) });
        self.showWriteOffDialog(true);
    };

    self.onWriteOffCancelDialog = function () {
        self.onCancelDialog();
        self.parent.editedCategory(null);
        self.showWriteOffDialog(false);
        self.writeoffItem(null);
    };

    self.onWriteOffApplyDialog = function (data) {
        data = data.object;
        var item = 'count_edit';
        if (item in self && 'hasError' in self[item]) {
            self[item].valueHasMutated();
            if (self[item].hasError()) {
                return;
            }
        }
        call_ajax_to_service(
                        self.rootApi() + '/writeoff',
                        "POST",
                        { id: data.id(), count: data.count_edit() },
                        data.id(),
                        function (callBackData, method, responseData) {
                            if (responseData.status.Code == 0) {
                                ko.utils.arrayForEach(self.rootApiItems(), function (item) {
                                    if (item.id() == callBackData) {
                                        item.toolscount(responseData.response);
                                    }
                                });
                                self.onWriteOffCancelDialog();
                            }
                        });
    }



    self.onIncIssueTool = function (item) {
        call_ajax_to_service(
                'workers',
                "GET",
                null,
                null,
                function (callBackData, method, responseData) {
                    if (responseData.status.Code == 0) {
                        self.parent.editedCategory(self);
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
                        self.incIssueItem(obj);
                        self.showIncomingIssueDialog(true);
                        self.allWorkers(ko.utils.arrayMap(responseData.response.data, function (item) {
                            return { id: item.id, name: item.lastname + ' ' + item.firstname + ' ' + item.middlename }
                        }));
                    }
                });
    };

    self.onIncIssueCancelDialog = function () {
        self.onCancelDialog();
        self.parent.editedCategory(null);
        self.showIncomingIssueDialog(false);
        self.incIssueItem(null);
    };

    self.onIncIssueApplyDialog = function (data) {
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
            call_ajax_to_service(
                    self.rootApi() + '/incissue',
                    "POST",
                    { id: ko.unwrap(data.id), count: ko.unwrap(data.count_edit), isinc: ko.unwrap(self.isincoming), workerid: ko.unwrap(worker.id) },
                    ko.unwrap(data.id),
                    function (callBackData, method, responseData) {
                        if (responseData.status.Code == 0) {
                            ko.utils.arrayForEach(self.rootApiItems(), function (item) {
                                if (item.id() == callBackData) {
                                    item.toolsinuse(responseData.response);
                                }
                            });
                            self.onIncIssueCancelDialog();
                        }
                    });
        } else {
            data.worker_edit(null);
        }
    };

    self.toolInfo = function (item) {
        call_ajax_to_service(
            self.rootApi() + '/used',
            "POST",
            { id: ko.unwrap(item.id) },
            null,
            function (callBackData, method, responseData) {
                if (responseData.status.Code == 0) {
                    self.infoItem({
                        items: ko.utils.arrayMap(responseData.response, function (item) {
                            return {
                                worker: new Worker(item.worker),
                                id: item.tool.id,
                                name: item.tool.name,
                                count: item.count
                            }
                        }),
                        toolname: responseData.response[0].tool.name
                    });
                    self.parent.editedCategory(self);
                    self.showInfoDialog(true);
                }
            });
    };

    self.onIncommingToolFromInfo = function (item) {
        self.onInfoCancelDialog();
        self.isincoming(true);
        self.onIncIssueTool(item);
    };

    self.onInfoCancelDialog = function () {
        self.onCancelDialog();
        self.parent.editedCategory(null);
        self.showInfoDialog(false);
        self.infoItem(null);
    };
}