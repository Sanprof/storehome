Date.prototype.startDate = function () {
    return new Date(this.getFullYear(), this.getMonth(), this.getDate());
};

Date.prototype.daysAdd = function (count) {
    return new Date(this.setDate(this.getDate() + count));
};

Date.prototype.monthsAdd = function (count) {
    return new Date(this.setMonth(this.getMonth() + count));
};

var timeZone = (new Date()).getTimezoneOffset() * -1;

Date.prototype.localtimestr = function () {
    this.setMinutes(this.getMinutes() + timeZone);
    var hours = this.getHours();
    var minutes = this.getMinutes();
    return (hours < 10 ? '0' + hours : hours) + ':' + (minutes < 10 ? '0' + minutes : minutes)
}

Date.prototype.utctimestr = function () {
    this.setMinutes(this.getMinutes() - timeZone);
    var hours = this.getHours();
    var minutes = this.getMinutes();
    return (hours < 10 ? '0' + hours : hours) + ':' + (minutes < 10 ? '0' + minutes : minutes)
}

function SLICFormat(newDate) {
    var self = this;
    var dateVar = newDate ? newDate : this;
    self.year = dateVar.getFullYear();
    self.month = dateVar.getMonth() + 1;
    self.day = dateVar.getDate();
    self.hours = dateVar.getHours();
    self.minutes = dateVar.getMinutes();

    self.fullFormat = function () {
        return (self.day < 10 ? '0' + self.day : self.day) + '.' +
            (self.month < 10 ? '0' + self.month : self.month) + '.' +
            (self.year < 10 ? '0' + self.year : self.year) + ' ' +
            self.shortTime();
    };

    self.fullFormatUTC = function () {
        return (self.day < 10 ? '0' + self.day : self.day) + '.' +
            (self.month < 10 ? '0' + self.month : self.month) + '.' +
            (self.year < 10 ? '0' + self.year : self.year) + 'T' +
            self.shortTime();
    };

    self.shortTime = function () {
        return (self.hours < 10 ? '0' + self.hours : self.hours) + ':' +
            (self.minutes < 10 ? '0' + self.minutes : self.minutes);
    };
}

Date.prototype.slicFormat = function () {
    var self = this;
    SLICFormat.call(self);

    self.shortFormat = function () {
        return (self.day < 10 ? '0' + self.day : self.day) + '.' +
            (self.month < 10 ? '0' + self.month : self.month) + '.' +
            (self.year < 10 ? '0' + self.year : self.year);
    };

    return self.shortFormat();
};

String.prototype.slicFormat = function () {
    var arr = this.split('.');
    return new Date(arr[2], arr[1] - 1, arr[0]);
}

String.prototype.slicFormatWithTime = function () {
    var dateAndTime = this.split(" ");
    var dateArr = dateAndTime[0].split('.');
    var timeArr = ['00', '00'];
    if (dateAndTime.length > 1) {
        timeArr = dateAndTime[1].split(':');
    }
    return new Date(dateArr[2], dateArr[1] - 1, dateArr[0], timeArr[0], timeArr[1], (timeArr.length > 2 ? timeArr[2] : 0));
}

Date.prototype.slicFormatWithTimeToLocal = function () {
    var copiedDate = new Date(this);
    copiedDate.setMinutes(copiedDate.getMinutes() + timeZone);
    SLICFormat.call(this, copiedDate);
    return this.fullFormat();
};

Date.prototype.slicFormatWithTimeToUtc = function () {
    var copiedDate = new Date(this);
    copiedDate.setMinutes(copiedDate.getMinutes() - timeZone);
    SLICFormat.call(this, copiedDate);
    return this.fullFormatUTC();
};

Date.prototype.toUtc = function () {
    var copiedDate = new Date(this);
    copiedDate.setMinutes(copiedDate.getMinutes() - timeZone);
    return copiedDate;
};

Date.prototype.toLocal = function () {
    var copiedDate = new Date(this);
    copiedDate.setMinutes(copiedDate.getMinutes() + timeZone);
    return copiedDate;
};

Date.prototype.slicFormatLong = function () {
    var self = this;
    SLICFormat.call(self);

    self.longFormat = function () {
        return (self.day < 10 ? '0' + self.day : self.day) + ' ' +
            monthsShort[self.month - 1] + ' ' +
            self.shortTime();
    };

    return self.longFormat();
};

Date.prototype.slicFormatWithTime = function () {
    SLICFormat.call(this);
    return this.fullFormat();
};

var TimeFirst = function (time) {
    var timeArr = time.split(':');
    var d = new Date(0);
    d.setYear(1);
    d.setHours(timeArr[0]);
    d.setMinutes(timeArr[1]);
    return d;
}

String.prototype.parseUTC = function () {
    var datestr = this.split(/[-T.]/);
    datestr[0] = datestr.splice(1, 1, datestr[0])[0];
    var times = ['00', '00'];
    if (datestr.length > 3) {
        var times = datestr[3].split(':');
    }
    var safdat = new Date(datestr.slice(0, 3).join('/') + ' ' + times[0] + ':' + times[1] + ':' + (times.length > 2 ? times[2] : '00'));
    return new Date(safdat.getTime() + timeZone * 60000);
}

Date.prototype.clone = function () {
    return new Date(this);
};

var slicFormatParse = function (strVal) {
    if (strVal) {
        var matches = strVal.match(/^(\d{2}).(\d{2}).(\d{4}).(\d{2}).(\d{2})$/);
        // also matches 22.05.2013 11:25
        if (matches === null) {
            return NaN;
        } else {
            // now lets check the date sanity
            var year = parseInt(matches[3], 10);
            var month = parseInt(matches[2], 10) - 1; // months are 0-11
            var day = parseInt(matches[1], 10);
            var hour = parseInt(matches[4], 10);
            var minute = parseInt(matches[5], 10);
            var date = new Date(year, month, day, hour, minute);
            if (date.getFullYear() === year
              && date.getMonth() === month
              && date.getDate() === day
              && date.getHours() === hour
              && date.getMinutes() === minute) {
                return new Date(year, month, day, hour, minute);
            }
        }
    } else {
        return NaN;
    }
};

var datesToLocal = function (datesArr) {
    for (var i = 0; i < datesArr.length; i++) {
        var prefix = datesArr[i].length == 5 ? "" : datesArr[i].substring(0, datesArr[i].length - 5);
        var time = (datesArr[i].length == 5 ? datesArr[i] : datesArr[i].substring(datesArr[i].length - 5))
        var d = TimeFirst(time);
        var str = d.slicFormatWithTimeToLocal();
        datesArr[i] = prefix + str.substring(str.length - 5);
    }
}

var days = [
    { day: 'Mo', fullday: 'Monday' },
    { day: 'Tu', fullday: 'Tuesday' },
    { day: 'We', fullday: 'Wednesday' },
    { day: 'Th', fullday: 'Thursday' },
    { day: 'Fr', fullday: 'Friday' },
    { day: 'Sa', fullday: 'Saturday' },
    { day: 'Su', fullday: 'Sunday' }
];

var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
var monthsShort = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];