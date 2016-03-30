window["AuditManager"] = function AuditManager(parent) {
    var self = this
    Manager.call(self);
    PartialListManager.call(self);

    self.headerName("Аудит действий по инструментам");
    self.iconCSS("fa-envelope-o");
    self.rootApi('audit');
    self.rootApiClass("Audit");
    self.sortASC(false);
    self.sortField("creationdate");
    self.templateName('audits');
    self.manualLoadOnPageSize(true);
    self.pageSize(100);
    self.manualLoadOnPageSize(false);
    this.radioSelectedOptionValue = ko.observable(1);

    self.extendedParams({
        showfilter: ko.unwrap(this.radioSelectedOptionValue)
    });

    self.setReadAll = function () {

    };

    self.setRead = function (data) {
        call_ajax_to_service(
                self.rootApi() + '/setreaded',
                "POST",
                { ids: [data.id] },
                null,
                function (callBackData, method, responseData) {
                    if (responseData.status.Code == 0) {
                        self.initialize();
                    }
                });
    };

    this.All = ko.computed(
        {
            read: function () {
                return self.radioSelectedOptionValue() == 0;
            },
            write: function (value) {
                if (value)
                    self.radioSelectedOptionValue(0);
            }
        });
    this.OnlyNew = ko.computed(
        {
            read: function () {
                return self.radioSelectedOptionValue() == 1;
            },
            write: function (value) {
                if (value)
                    self.radioSelectedOptionValue(1);
            }
        });
    this.OnlyReaded = ko.computed(
        {
            read: function () {
                return self.radioSelectedOptionValue() == 2;
            },
            write: function (value) {
                if (value)
                    self.radioSelectedOptionValue(2);
            }
        });

    self.changeFilter = function (filter, data) {
        self.radioSelectedOptionValue(filter);
        self.extendedParams().showfilter = ko.unwrap(this.radioSelectedOptionValue);
        self.initialize();
    }
}