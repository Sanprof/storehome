window["ToolsManager"] = function ToolsManager() {
    var self = this;
    Manager.call(self);
    PartialListManager.call(self);

    self.rootApi('tools');
    self.sortField('category');
}