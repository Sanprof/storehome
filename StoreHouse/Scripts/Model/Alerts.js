var alertOptions = {
    prefix: "",
    sufix: "",
    messParams: []
}
var alertStatuses = {
    success: {
        type: "success",
        options: alertOptions
    },
    info: {
        type: "info",
        options: alertOptions
    },
    warning: {
        type: "warning",
        options: alertOptions
    },
    error: {
        type: "danger",
        options: alertOptions
    }
}

var alertList = new function () {
    var self = this;
    self.add = function (alertStatus, message, params) {
        $.growl({
            icon: 'glyphicon glyphicon-warning-sign',
            message: "<span class=\"message-text\">" + alertStatus.options.prefix + StringFormatter.Format(message, params) + alertStatus.options.sufix + "<span>"
        }, {
            element: 'body',
            type: alertStatus.type,
            allow_dismiss: true,
            placement: {
                from: "top",
                align: "right"
            },
            offset: {
                x: 20,
                y: pageYOffset == 0 ? 50 : 10
            },
            spacing: 5,
            z_index: 1031,
            delay: 5000,
            timer: 1000,
            mouse_over: true,
            icon_type: 'class',
            template: "<div data-growl=\"container\" class=\"alert\" role=\"alert\">" +
	            "<button type=\"button\" class=\"close\" data-growl=\"dismiss\">" +
		        "<span aria-hidden=\"true\">×</span>" +
		        "<span class=\"sr-only\">Close</span>" +
	            "</button>" +
	            "<span data-growl=\"icon\" style=\"margin-right: 10px;\"></span>" +
	            "<span data-growl=\"message\"></span>" +
            "</div>"
        });
    };
}