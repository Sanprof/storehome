function Confirmation() {
    var self = this;
    self.currentConfirmText = ko.observable();
    self.showDialog = ko.observable(false);
    self.applyCommand = ko.observable();
    self.afterCancelCommand = ko.observable();
    self.stayModalState = ko.observable();
    self.applyCommandData = ko.observable();
    self.cnfrmBtn = ko.observable();
    self.cancelBtnText = ko.observable();
    self.confirm = function (confirmText, data, applyFunc, afterCancelFunc, cnfrmBtn, stayModalState, cancelBtnText) {
        self.applyCommand(applyFunc);
        self.afterCancelCommand(afterCancelFunc);
        self.applyCommandData(data);
        self.cnfrmBtn(cnfrmBtn);
        self.stayModalState(stayModalState);
        self.cancelBtnText(cancelBtnText == null ? "Отмена" : cancelBtnText);
        self.currentConfirmText(confirmText);
        self.showDialog(true);
    };
    self.onApplyClick = function (data) {
        if (typeof self.applyCommand() == 'function') {
            self.applyCommand()(self.applyCommandData());
        }
        self.cancelConfirmDialog();
    };
    self.cancelConfirmDialog = function (data) {
        self.showDialog(false);
        self.currentConfirmText(null);
        self.applyCommand(null);
        self.applyCommandData(null);
        if (!self.stayModalState()) {
            $('body').find('.modal-backdrop').remove();
            $('body').removeAttr('class');
            $('body').removeAttr('style');
        }
        if (typeof (self.afterCancelCommand()) == 'function') {
            self.afterCancelCommand()();
        }
    }
}

var confirmBtn = {
    "delete": {
        text: "Удалить",
        head_text: "Подтвердите удаление",
        cssClass: "btn-danger"
    },
    "confirm": {
        text: "Подтвердить",
        head_text: null,
        cssClass: "btn-success"
    },
    "run": {
        text: "Run",
        head_text: null,
        cssClass: "btn-primary"
    },
    "apply": {
        text: "Применить",
        head_text: null,
        cssClass: "btn-primary"
    }
}