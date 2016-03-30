function BaseObject() {
    var self = this;
    self.properiesMap = ko.observableArray();
    self.token = ko.computed(function () {
        var token = readCookie('token');
        return (typeof token == 'undefined' ? null : token);
    });

    self.init = function (data) {
        if (data) {
            for (var prop in data) {
                if (prop in self) {
                    if (ko.isObservable(self[prop])) {
                        if (typeof data[prop] != 'object')
                            self[prop](data[prop]);
                    }
                    else
                        self[prop] = data[prop];
                }
            }
            self.updatePropertiesMap(data);
        }
    };
    self.updatePropertiesMap = function (data) {
        for (var prop in data) {
            if (self.properiesMap.indexOf(prop) < 0) {
                self.properiesMap.push(prop);
            }
        }
    };
    self.IsValid = function (allKeys) {
        var isValid = true;
        var keys = allKeys != null ? getKeys(self) : self.properiesMap();
        ko.utils.arrayForEach(keys, function (item) {
            if (item in self && self[item] != undefined && ko.isObservable(self[item]) && 'hasError' in self[item]) {
                self[item].valueHasMutated();
                if (self[item].hasError()) {
                    isValid = false;
                }
            }
        });
        return isValid;
    };

    var getKeys = function (obj) {
        var keys = [];
        for (var key in obj) {
            keys.push(key);
        }
        return keys;
    }

    self.toJSON = function (includeToken) {
        if (includeToken) {
            self.properiesMap.push("token");
        }
        var json_str = "{";
        var firstComma = false;
        for (var prop in self) {
            var json_prop = prop;
            if (prop.indexOf("_") > -1) {
                json_prop = prop.replace(/_/g, "-");
            }
            if (self.properiesMap.indexOf(json_prop) > -1) {
                json_str += (firstComma ? "," : "") + "\"" + json_prop + "\":";
                if (ko.isObservable(self[prop])) {
                    if (self[prop]() != null && typeof self[prop]() == 'object' && 'toJSON' in self[prop]()) {
                        json_str += self[prop]().toJSON();
                    }
                    else if (self[prop]() instanceof Array) {
                        json_str += "[";
                        var firstCommaInArray = false;
                        for (var i = 0; i < self[prop]().length; i++) {
                            if (typeof self[prop]()[i] == 'object' && 'toJSON' in self[prop]()[i]) {
                                json_str += (firstCommaInArray ? "," : "") + self[prop]()[i].toJSON();
                                firstCommaInArray = true;
                            }
                        }
                        json_str += "]";
                    }
                    else
                        json_str += ko.toJSON(self[prop]());
                }
                else
                    json_str += ko.toJSON(self[prop]);
                firstComma = true;
            }
        }
        return json_str += "}";
    };

    self.toJS = function () {
        var json = {};
        for (var prop in self) {
            if (self.properiesMap.indexOf(prop) > -1) {
                json[prop] = ko.unwrap(self[prop]);
            }
        }
        return json;
    };
}