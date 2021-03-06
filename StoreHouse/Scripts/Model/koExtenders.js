﻿ko.extenders.required = function (target, overrideMessage) {
    target.hasError = ko.observable(false);
    target.validationMessage = ko.observable();

    function validate(newValue) {
        target.hasError($.trim(newValue) ? false : true);
        target.validationMessage($.trim(newValue) ? "" : overrideMessage || "This field is required");
    };

    validate(target());
    target.subscribe(validate);
    return target;
};

ko.extenders.floatrequired = function (target, overrideMessage) {
    target.hasError = ko.observable(false);
    target.validationMessage = ko.observable();

    function validate(newValue) {
        var val = $.trim(newValue);
        if (val.length > 0) {
            target.hasError(newValue.indexOf(',') >= 0 || isNaN(parseFloat(newValue)));
            target.validationMessage("Incorrect value!");
        } else {
            target.hasError(true);
            target.validationMessage("Value is required!");
        }
    };

    validate(target());
    target.subscribe(validate);
    return target;
};

ko.extenders.daysOfRequired = function (target, overrideMessage) {
    target.hasError = ko.observable(false);
    target.validationMessage = ko.observable();

    function validate(newValue) {
        target.hasError(newValue.length == 0);
        target.validationMessage(newValue.length > 0 ? "" : overrideMessage || "This field is required");
    };

    validate(target());
    target.subscribe(validate);
    return target;
};

ko.extenders.datetime = function (target, overrideMessage) {
    target.hasError = ko.observable(false);
    target.validationMessage = ko.observable();

    function validate(newValue) {
        target.hasError(validateDatetime(newValue));
        target.validationMessage($.trim(newValue) ? "" : "The datetime has incorrect format");
    };

    validate(target());
    target.subscribe(validate);
    return target;

    function validateDatetime(newValue) {
        var date = newValue ? slicFormatParse(newValue instanceof Date ? newValue.slicFormatWithTime() : newValue) : NaN;
        return isNaN(date);
    }
};

ko.extenders.minMax = function (target, minMaxValues) {
    target.hasError = ko.observable(false);
    target.validationMessage = ko.observable();
    target.min = ko.observable(minMaxValues.min);
    target.max = ko.observable(minMaxValues.max);

    function validate(newValue) {
        var hasError = !($.trim(newValue)) || ($.trim(newValue) && (newValue < ko.unwrap(target.min) || newValue > ko.unwrap(target.max)));
        target.hasError(hasError);
        target.validationMessage(!hasError ? "" : "Значение должно быть в пределах от " + ko.unwrap(target.min) + " до " + ko.unwrap(target.max));
    };

    validate(target());
    target.subscribe(validate);
    return target;
};