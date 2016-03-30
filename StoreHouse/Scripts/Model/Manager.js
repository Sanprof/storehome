function Manager() {
    var self = this;
    BaseObject.call(self);
    Eventable.call(self);
    self.rootApi = ko.observable();
    self.rootApiItems = ko.observableArray();
    self.rootApiClass = ko.observable();
    self.selectedItem = ko.observable();
    self.showDialog = ko.observable(false);
    self.iconCSS = ko.observable();
    self.firstInited = ko.observable(false);
    self.headerName = ko.observable();
    self.templateName = ko.observable();

    self.initialize = function () {
        call_ajax_to_service(self.rootApi(),
            "GET",
            null,
            self.rootApiItems,
            function (callBackData, method, responseData) {
                callBackData(ko.utils.arrayMap(responseData.response, function (arrItem) {
                    return new window[self.rootApiClass()](arrItem);
                }));
                self.firstInited(true);
            });
    }

    self.onCancelDialog = function (data) {
        self.showDialog(false);
        self.selectedItem(null);
        $('body').find('.modal-backdrop').remove();
        $('body').removeAttr('class');
        $('body').removeAttr('style');
    };
}