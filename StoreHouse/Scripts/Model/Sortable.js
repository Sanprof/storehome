function Sortable() {
    var self = this;
    self.manualLoadOnPageSize = ko.observable(false);
    self.emptyListMessage = ko.observable();
    self.pageSize = ko.observable(10);
    self.pageSize.subscribe(function (newValue) {
        self.pageIndex(1);
        self.tablePager.recalc(self.pageIndex(), self.itemsCount(), self.pageSize());
        if (self.loadPartialData && !self.manualLoadOnPageSize()) {
            self.loadPartialData();
        }
    });
    self.sortableHead = new SortableHeader();
    self.tablePager = new TablePager(self);
    self.pageSizes = recordsPerPage;
    self.search = ko.observable().extend({ throttle: 500 });
    self.search.subscribe(function (newValue) {
        if (self.loadPartialData) {
            self.loadPartialData();
        }
    });
    self.pageIndex = ko.observable(1);
    self.pageIndex.subscribe(function (newValue) {
        if (self.loadPartialData) {
            self.loadPartialData();
        }
    });
    self.sortField = ko.observable();
    self.headFileds = ko.observableArray();
    self.sortASC = ko.observable(true);
    self.itemsCount = ko.observable(0);
    self.itemsCount.subscribe(function (newValue) {
        self.tablePager.recalc(self.pageIndex(), self.itemsCount(), self.pageSize());
    });
    self.pageFrom = ko.computed(function () {
        return (self.pageIndex() - 1) * self.pageSize() + 1;
    });
    self.pageTo = ko.computed(function () {
        return self.pageIndex() * self.pageSize() < self.itemsCount() ? (self.pageFrom() + self.pageSize() - 1) : self.itemsCount();
    });
    self.onChangeSortable = function (field, data, event) {
        if (event.target.nodeName.toLowerCase() !== 'i') {
            if (field != self.sortField()) {
                self.sortField(field);
                self.sortASC(true);
            } else {
                self.sortASC(!self.sortASC());
            }
            if (self.loadPartialData) {
                self.loadPartialData();
            }
        }
    };
    self.emptyMessage = ko.computed(function () {
        if (self.search()) {
            return 'There are no records matching your searching criteria';
        } else {
            return self.emptyListMessage();
        }
    });

    self.emptyColspan = ko.computed(function () {
        return self.sortableHead.headSortableArray().length;
    });
}