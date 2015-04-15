window["ToolsControlManager"] = function ToolsControlManager() {
    var self = this;

    Manager.call(self);

    self.headerName("Инcтрументы");
    self.iconCSS("fa-gears");
    self.templateName = 'tools';
    self.flatTools = ko.observable(false);

    self.categoryManager = new CategoryManager();
    self.toolManager = new ToolsManager();

    self.initialize = function () {
        self.categoryManager.initialize();
    }
}