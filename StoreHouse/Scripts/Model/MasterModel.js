function MasterModel() {
    var self = this;
    self.staticTitle = "Склад - ";
    //self.StartPageManager = ko.observable();
    //self.ToolsManager = ko.observable();
    self.UserManager = ko.observable();

    self.displayName = ko.observable();
    self.activeManager = ko.observable();
    self.templateName = ko.observable();

    self.onMenuItemClick = function (managerName, args, specialName, data) {
        setAllManagersNotActive();
        self.activeManager(null);
        if (data == null) {
            specialName = managerName;
        }
        if (!(specialName in self)) {
            self[specialName] = ko.observable();
        } else {
            self[specialName](null);
        }
        if (window[managerName]) {
            manager = new window[managerName](self, args);
            self.displayName("<i class=\"fa " + manager.iconCSS() + "\"></i> " + manager.headerName());
            self.templateName(manager.templateName);
            self.activeManager(manager);
            manager.initialize();
            if (ko.unwrap(self[specialName]) == null) {
                self[specialName](manager);
            }
            document.title = self.staticTitle + manager.headerName();
        }
        return true;
    };

    var setAllManagersNotActive = function () {
        for (var prop in self) {
            if (prop.indexOf('Manager') >= 0) {
                if (self[prop] != null &&
                'isActive' in self[prop]) {
                    self[prop].isActive(false);
                }
            }
        }
    }

    self.logout = function () {
        call_ajax_to_service(
                "token/logoff",
                "POST",
                null,
                null,
                function (callBackData, method, responseData) {
                    if (responseData.status.Code == 0) {
                        delete_cookie('token');
                        location.reload();
                    }
                });
    };

    self.privilege = function () {
        var access = readCookie('access');
        return (typeof access == 'undefined' || access == null ? null : true);
    };

    self.username = ko.computed(function () {
        return readCookie('username');
    });

    self.onMenuItemClick("StartPageManager");
}
