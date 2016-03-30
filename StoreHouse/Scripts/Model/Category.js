window["Category"] = function Category(data) {
    var self = this;
    Manager.call(self);
    PartialListManager.call(self);
    DescrName.call(self);
    self.cellfrom = ko.observable();
    self.cellto = ko.observable();
    self.candelete = ko.observable();

    self.showWriteOffDialog = ko.observable(false);
    self.writeoffItem = ko.observable();

    self.showIssueDialog = ko.observable(false);
    self.issueItem = ko.observable();

    self.showInfoDialog = ko.observable(false);
    self.infoItem = ko.observable();

    self.expanded = ko.observable(false);

    self.toolpositions = ko.observable();
    self.toolscount = ko.observable();
    self.tools = ko.observableArray();
    self.allWorkers = ko.observableArray();
    self.rootApi('tools/incat');
    self.rootApiClass('Tool');
    self.sortField('name');
    self.needReloadInfo = ko.observable(false);

    if (data) {
        self.init(data);
    }

    var baseStartEdit = self.startEdit;
    self.startEdit = function () {
        baseStartEdit();
        self.cellfrom_edit = ko.observable(ko.unwrap(self.cellfrom)).extend({ required: "Обязательно" });
        self.cellfrom_edit.hasError(false);
        self.cellto_edit = ko.observable(ko.unwrap(self.cellto)).extend({ required: "Обязательно" });
        self.cellto_edit.hasError(false);
    };

    var baseEndEdit = self.endEdit;
    self.endEdit = function () {
        baseEndEdit();
        self.cellfrom(ko.unwrap(self.cellfrom_edit));
        self.cellto(ko.unwrap(self.cellto_edit));
    };

    var baseToJSON = self.toJSON;
    self.toJSON = function () {
        var obj = baseToJSON();
        obj.cellfrom = ko.unwrap(self.cellfrom);
        obj.cellto = ko.unwrap(self.cellto);
        return obj;
    };

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
        tool.min(ko.unwrap(self.cellfrom));
        tool.max(ko.unwrap(self.cellto));
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
        self.writeoffItem({
            id: item.id,
            name: item.name,
            count_edit: ko.observable(1).extend({ minMax: { min: 1, max: (item.toolscount() - item.toolsinuse()) } }),
            comment_edit: ko.observable().extend({ required: "Причина обязательно" })
        });
        self.writeoffItem().comment_edit.hasError(false);
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
        for (var item in data) {
            if ('hasError' in data[item]) {
                data[item].valueHasMutated();
                if (data[item].hasError()) {
                    return;
                }
            }
        }
        call_ajax_to_service(
                        self.rootApi() + '/writeoff',
                        "POST",
                        { id: data.id(), count: data.count_edit(), comment: data.comment_edit() },
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



    self.onIssueTool = function (item) {
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
        self.parent.editedCategory(null);
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

    self.applyIncIssue = function (toolID, count, workerID, isincoming, onSuccess) {
        if (!isincoming) {
            self.candelete(false);
        }
        call_ajax_to_service(
                self.rootApi() + '/incissue',
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
            ko.unwrap(item.worker.id),
            true,
            function (callBackData, method, responseData) {
                if (responseData.status.Code == 0) {
                    var worker = ko.utils.arrayFirst(ko.unwrap(self.infoItem().items), function (elem) {
                        return ko.unwrap(elem.worker.id) == ko.unwrap(item.worker.id);
                    });
                    if (worker) {
                        worker.count(ko.unwrap(worker.count) - ko.unwrap(item.valueToIncoming));
                        if (worker.count() > 0) {
                            worker.valueToIncoming(1);
                        } else {
                            self.infoItem().items.remove(worker);
                        }
                        if (ko.unwrap(self.infoItem().items).length == 0) {
                            self.onInfoCancelDialog();
                        }
                    }
                }
            });
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
                        items: ko.observableArray(ko.utils.arrayMap(responseData.response, function (item) {
                            function EditingObject() {
                                var self = this;
                                self.worker = new Worker(item.worker);
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
                        toolname: responseData.response[0].tool.name
                    });
                    self.parent.editedCategory(self);
                    self.showInfoDialog(true);
                }
            });
    };

    self.onInfoCancelDialog = function () {
        self.onCancelDialog();
        if (self.needReloadInfo() == true) {
            self.parent.editedCategory().loadPartialData();
            self.needReloadInfo(false);
        }
        self.parent.editedCategory(null);
        self.showInfoDialog(false);
        self.infoItem(null);
    };

    self.selectWorker = function (obj, worker) {
        obj.worker_edit(worker.name);
    };

    self.setToolsMinMax = function (data) {
        ko.utils.arrayForEach(self.rootApiItems(), function (item) {
            item.min(ko.unwrap(self.cellfrom));
            item.max(ko.unwrap(self.cellto));
            item.parent = self;
        });
    }

    self.subscribe("dataloadedevent", self.setToolsMinMax);
}

