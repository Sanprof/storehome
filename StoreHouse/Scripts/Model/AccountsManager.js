window["AccountsManager"] = function AccountsManager(parent) {
    var self = this
    Manager.call(self);
    PartialListManager.call(self);

    self.headerName("Учетные записи");
    self.iconCSS("fa-user-plus");
    self.rootApi('accounts');
    self.rootApiClass("Account");
    self.sortField("username");
    self.templateName = 'accounts';
}