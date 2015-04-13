window["StartPageManager"] = function StartPageManager() {
    var self = this;
    Manager.call(self);
    PartialListManager.call(self);

    self.headerName("Главная");
    self.iconCSS("fa-bar-chart");
    self.rootApi('startpage');
    self.rootApiClass("StartPageItem");
    self.sortField("time");
    self.sortASC(false);
    self.templateName = 'startpage';
    self.manualLoadOnPageSize(true);
    self.pageSize(100);

    self.allTools = ko.observable();
    self.toolsInUse = ko.observable();
    self.freeTools = ko.computed(function () {
        return self.allTools() - self.toolsInUse();
    });

    self.dataLoadedEvent = function () {
        call_ajax_to_service(
            self.rootApi() + '/summary',
            'GET',
            null,
            self,
            function (callBackData, method, responseData) {
                if (responseData.status.Code == 0) {
                    self.allTools(responseData.response.all);
                    self.toolsInUse(responseData.response.inuse);
                }
            });
    };

    self.subscribe('dataLoadedEvent', self.dataLoadedEvent);
}