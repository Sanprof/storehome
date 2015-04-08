function LoginUser(data) {
    var self = this;
    BaseObject.call(self);
    self.id = ko.observable();
    self.email = ko.observable().extend({ required: "Email is required!" });
    self.username = ko.observable().extend({ required: "Username is required!" });
    self.password = ko.observable().extend({ required: "" });
    self.rememberme = ko.observable();
    self.waitingForService = ko.observable(false);
    self.recoverPassword = ko.observable(false);
    self.recoveredComplete = ko.observable(false);

    if (data) {
        self.init(data);
        self.email.hasError(false);
        self.username.hasError(false);
        self.password.hasError(false);
    }

    self.onFogotClick = function () {
        self.recoverPassword(!self.recoverPassword());
    };

    self.validate = function () {
        if (self.IsValid()) {
            self.waitingForService(true);
            call_ajax_to_service(
                "token/auth",
                "POST",
                self.toJSON(),
                self,
                function (callBackData, method, responseData) {
                    if (responseData.status.Code == 0) {
                        if (responseData.token) {
                            var days = responseData.response.rememberme ? 30 : 1;
                            createCookie('token', responseData.token, days);
                            createCookie('username', responseData.response.username, days);
                            if (responseData.response.privilege) {
                                createCookie('access', responseData.response.privilege, days);
                            } else {
                                delete_cookie('access');
                            }
                        }
                        window.location = 'http://' + window.location.host + '/' + window.location.hash;
                    } else {
                        self.password(null);
                        self.password.hasError(false);
                        self.waitingForService(false);
                    }
                },
                function () {
                    self.waitingForService(false);
                }
                );
        } else {
            alertList.add(alertStatuses.warning, messageJournal.fill_email_and_password);
        }
    };

    self.recoverClick = function () {
        self.password.hasError(false);
        self.email.valueHasMutated();
        if (!self.email.hasError()) {
            self.waitingForService(true);
            call_ajax_to_service(
                "passrecover",
                "POST",
                { email: ko.unwrap(self.email), host: window.location.host },
                self,
                function (callBackData, method, responseData) {
                    if (responseData.status.Code == 0) {
                        alertList.add(alertStatuses.success, messageJournal.password_recovered);
                        self.recoveredComplete(true);
                        setTimeout(function () { window.location = 'http://' + window.location.host; }, 4000);
                    }
                    self.waitingForService(false);
                },
                function () {
                    self.waitingForService(false);
                }
                );
        } else {
            alertList.add(alertStatuses.warning, messageJournal.fill_email);
        }
    };

    self.rememberMeClick = function () {
        self.rememberme(!self.rememberme());
    };
}