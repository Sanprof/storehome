function PartialListManager() {
    var self = this;
    Sortable.call(self);
    Eventable.call(self);
    self.extendedParams = ko.observable();

    self.initialize = function () {
        self.loadPartialData();
    };

    self.loadPartialData = function () {
        var url = self.rootApi();
        var json = {};
        url = self.rootApi() + "/partial";
        json.psize = self.pageSize();
        json.pindex = self.pageIndex();
        json.sort = {
            field: self.sortField(),
            asc: self.sortASC(),
            search: self.search()
        };
        if (self.extendedParams()) {
            json["extend"] = self.extendedParams();
        }
        call_ajax_to_service(url,
            "GET",
            json,
            self.rootApiItems,
            function (callBackData, method, responseData) {
                if (responseData.status.Code == 0) {
                    if (responseData.response) {
                        self.itemsCount(responseData.response.count);
                        if (responseData.response.data) {
                            callBackData(ko.utils.arrayMap(responseData.response.data, function (arrItem) {
                                return new window[self.rootApiClass()](arrItem);
                            }));
                        }
                        self.eventFire('dataLoadedEvent', responseData.response);
                    }
                } else {
                    self.eventFire('errorDataLoadedEvent');
                }
            },
            function (message) {
                self.eventFire('errorDataLoadedEvent');
            });
    };

    self.IsAllChecked = ko.computed({
        read: function () {
            if (ko.unwrap(self.rootApiItems).length == 0) {
                return false;
            }
            return ko.utils.arrayFirst(self.rootApiItems(), function (item) {
                return ('checked' in item && item.checked() == false);
            }) == null;
        },
        write: function (arr, b) {
            for (var i = 0; i < arr.length; i++) {
                arr[i].checked(b);
            }
        }
    });

    self.oneIsChecked = ko.computed(function () {
        return ko.utils.arrayFirst(self.rootApiItems(), function (item) {
            return ('checked' in item && item.checked() == true);
        }) != null;
    });

    self.onCheckAll = function () {
        var b = self.IsAllChecked();
        ko.utils.arrayForEach(self.rootApiItems(), function (item) {
            if ('checked' in item) {
                item.onChecked(item, !b);
            }
        })
    };

    self.onAddUpdateSuccessfully = function (method, response, objName) {
        var obj = null;
        switch (method) {
            case 'PUT':
                if (response) {
                    if (self.pageSize() < self.itemsCount() + 1) {
                        var pCount = (self.itemsCount() / self.pageSize()) >> 0;
                        if (self.itemsCount() % self.pageSize() > 0) {
                            pCount++;
                        }
                        self.pageIndex(pCount);
                        self.loadPartialData();
                    } else {
                        obj = new window[objName](response);
                        self.rootApiItems.push(obj);
                        self.itemsCount(self.itemsCount() + 1);
                    }
                    self.onCancelDialog();
                }
                break;
            case 'POST':
                self.onCancelDialog();
                break;
        }
        return obj;
    };

    self.onDeleteSuccessfully = function (id) {
        if (self.pageSize() < self.itemsCount()) {
            self.loadPartialData();
            return ko.utils.arrayFirst(ko.unwrap(self.rootApiItems), function (item) {
                return item.id() === id;
            });
        } else {
            var removed = self.rootApiItems.remove(function (item) {
                return item.id() === id;
            });
            if (removed) {
                return removed[0];
            }
        }
        self.loadPartialData();
    };
}