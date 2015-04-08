var webApiServiceUrl = '/api';

function call_ajax_to_service(url, method, json_data, callbackData, callbackFunc, errorCallbackFunc) {
    var ajax_params = {
        type: method,
        url: webApiServiceUrl + '/' + url,
        success: function (responseData) {
            if (responseData && 'status' in responseData && responseData.status.Code > 0) {
                if (responseData.status.Code == 3) {
                    delete_cookie('token');
                    delete_cookie('access');
                    window.location = 'http://' + window.location.host + window.location.hash;
                    return;
                } else {
                    alertList.add(alertStatuses.error, responseData.status.Message || "Server error!");
                }
            }
            if (callbackFunc) {
                callbackFunc(callbackData, method, responseData);
            }
        },
        error: function (jqxhr, settings, thrownError) {
            if (errorCallbackFunc) {
                errorCallbackFunc(thrownError);
            }
            alertList.add(alertStatuses.error, thrownError || "Could not connect to the api server!");
        }
    }
    ajax_params["contentType"] = "application/json; charset=utf-8";

    if (json_data == null) {
        json_data = {};
    }
    if (typeof json_data == 'object') {
        json_data['token'] = readCookie('token');
        json_data = JSON.stringify(json_data);
    }
    if (method == "GET") {
        ajax_params["url"] += "?data=" + encodeURIComponent(json_data);
    } else {
        ajax_params["data"] = json_data;
    }

    $.ajax(ajax_params);
}

var getJsonToService = function (token, data) {
    return "{\"id\":" + id + ",\"token\":\"" + token + "\",\"data\":" + data + "}";
}

var keyCodeIsUNumber = function (keyCode, shiftKey, ctrlKey) {
    // Allow: backspace, delete, tab, escape, and enter
    if (keyCode == 46 || keyCode == 8 || keyCode == 9 || keyCode == 27 || keyCode == 13 ||
        // Allow: Ctrl+A
        (keyCode == 65 && ctrlKey === true) ||
        // Allow: home, end, left, right
        (keyCode >= 35 && keyCode <= 39)) {
        // let it happen, don't do anything
        return true;
    }
    else {
        // Ensure that it is a number and stop the keypress
        if (shiftKey || (keyCode < 48 || keyCode > 57) && (keyCode < 96 || keyCode > 105)) {
            return false;
        } else {
            return true
        }
    }
}