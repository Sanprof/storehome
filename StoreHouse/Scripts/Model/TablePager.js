function TablePager(parent) {
    var self = this;
    self.parent = parent;
    self.lastPageIndex = ko.observable();
    self.items = ko.observableArray();

    self.recalc = function (pageIndex, allCount, pageSize) {
        self.lastPageIndex(pageIndex);
        var pageCount = (allCount / pageSize) >> 0;
        if (allCount % pageSize > 0) {
            pageCount++;
        }
        var arr = [];
        var centerCount;
        arr.push({ value: pageIndex - 1, displayText: 'Previous', active: false, disabled: pageIndex == 1 })
        if (pageCount <= 10) {
            for (var i = 1; i < pageCount + 1; i++) {
                arr.push({ value: i, displayText: i, active: pageIndex == i, disabled: false });
            }
        }
        else if (pageCount == 11) {
            var startIndex = 1;
            for (var i = startIndex; i < startIndex + 1; i++) {
                arr.push({ value: i, displayText: i, active: pageIndex == i, disabled: false });
            }
            startIndex++;
            if (pageIndex > 5) {
                arr.push({ value: null, displayText: '...', active: false, disabled: true });
                startIndex += 2;
            }
            for (var i = startIndex; i < startIndex + 7; i++) {
                arr.push({ value: i, displayText: i, active: pageIndex == i, disabled: false });
            }
            startIndex += 7;
            if (pageIndex <= 5) {
                arr.push({ value: null, displayText: '...', active: false, disabled: true })
                startIndex += 2;
            }
            for (var i = startIndex; i < startIndex + 1; i++) {
                arr.push({ value: i, displayText: i, active: pageIndex == i, disabled: false });
            }
        }
        else if (pageCount > 11) {
            var startIndex = 1;
            for (var i = startIndex; i < startIndex + 1; i++) {
                arr.push({ value: i, displayText: i, active: pageIndex == i, disabled: false });
            }
            startIndex++;
            if (pageIndex > 5) {
                arr.push({ value: null, displayText: '...', active: false, disabled: true });
                if (pageCount - pageIndex > 5) {
                    startIndex = pageIndex - 2;
                } else {
                    startIndex = pageCount - 7;
                }
            }
            for (var i = startIndex; i < startIndex + 6; i++) {
                arr.push({ value: i, displayText: i, active: pageIndex == i, disabled: false });
            }
            startIndex += 6;
            if (pageIndex <= 5 || pageIndex < pageCount - 5) {
                arr.push({ value: null, displayText: '...', active: false, disabled: true })
                startIndex = pageCount;
            } else {
                arr.push({ value: startIndex, displayText: startIndex, active: pageIndex == startIndex, disabled: false });
            }
            for (var i = pageCount; i < pageCount + 1; i++) {
                arr.push({ value: i, displayText: i, active: pageIndex == i, disabled: false });
            }
        }
        arr.push({ value: pageIndex + 1, displayText: 'Next', active: false, disabled: pageIndex == pageCount })
        self.items(arr);
    }

    self.changePageIndex = function (pageIndex, allCount, pageSize, data) {
        self.recalc(pageIndex, allCount, pageSize);
        self.parent.pageIndex(pageIndex);
    }
}