window["WriteOffManager"] = function WriteOffManager() {
    var self = this;
    Manager.call(self);
    PartialListManager.call(self);

    self.headerName("Списанные инструменты");
    self.iconCSS("fa-trash");
    self.rootApi('writeoffs');
    self.rootApiClass("StartPageItem");
    self.sortField("time");
    self.sortASC(false);
    self.templateName = 'writeoffs';
}