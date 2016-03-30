window["ChangePasswordManager"] = function ChangePasswordManager() {
    var self = this;
    Manager.call(self);

    self.headerName('Изменение пароля');
    self.iconCSS('fa-edit');
    self.templateName('changepass');

    self.oldPass = ko.observable().extend({ required: "Старый пароль обязательно" });
    self.newPass = ko.observable().extend({ required: "Старый пароль обязательно" })
                                  .extend({
                                      validation: [{
                                          validator: function (value) {
                                              if (!value || value == "") {
                                                  return true;
                                              }
                                              return /(?=^[^\s]{6,128}$)((?=.*?\d)(?=.*?[A-Z])(?=.*?[a-z])|(?=.*?\d)(?=.*?[^\w\d\s])(?=.*?[a-z])|(?=.*?[^\w\d\s])(?=.*?[A-Z])(?=.*?[a-z])|(?=.*?\d)(?=.*?[A-Z])(?=.*?[^\w\d\s]))^.*/.test('' + value + '');
                                          },
                                          message: 'Длинна пароля должна быть от 6 до 128 символов, содержать миниму 1 заглавный и 1 строчный символ, а также 1 цифру и 1 спец. символ'
                                      }]
                                  });
    self.repeatPass = ko.observable().extend({ required: "Повторите новый пароль" })
                                     .extend({
                                         validation: [{
                                             validator: function (value) {
                                                 if (value != null) {
                                                     if (value == "" && self.newPass() == "") {
                                                         return true;
                                                     }
                                                     return value.length > 0 && value === self.newPass();
                                                 } else {
                                                     return false;
                                                 }
                                             },
                                             message: 'Пароли не совпадают'
                                         }]
                                     });
    self.newPassMessage = ko.observable();
    self.repeatPassMessage = ko.observable();

    self.initialize = function () {
        self.init({ oldPass: "", newPass: "", repeatPass: "" });
        self.oldPass.hasError(false);
        self.newPass.hasError(false);
        self.repeatPass.hasError(false);
    };

    self.submit = function () {
        var newPassHasError = false;
        if (!self.newPass.isValid()) {
            self.newPassMessage(self.newPass.error());
            newPassHasError = true;
        }
        var repeatPassHasError = false;
        if (!self.repeatPass.isValid()) {
            self.repeatPassMessage(self.repeatPass.error());
            repeatPassHasError = true;
        }
        var b = self.IsValid();
        if (newPassHasError) {
            self.newPass.hasError(true);
        }
        if (repeatPassHasError) {
            self.repeatPass.hasError(true);
        }
        if (!newPassHasError && !repeatPassHasError && b) {
            call_ajax_to_service(
                'workers/changepassword',
                "POST",
                { oldpass: self.oldPass(), newpass: self.repeatPass() },
                null,
                function (callBackData, method, responseData) {
                    if (responseData.status.Code == 0) {
                        alertList.add(alertStatuses.success, messageJournal.user_pass_was_changed);
                    }
                    self.oldPass(null);
                    self.newPass(null);
                    self.repeatPass(null);
                    self.oldPass.hasError(false);
                    self.newPass.hasError(false);
                    self.repeatPass.hasError(false);
                });
        }
    };
}