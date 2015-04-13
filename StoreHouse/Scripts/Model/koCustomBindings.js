ko.bindingHandlers.typeaHead = {
    init: function (element, valueAccessor) {
        ko.utils.domNodeDisposal.addDisposeCallback(element, function () { $(element).typeahead('destroy'); });
    },
    update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        var value = valueAccessor();
        var ceArray = ko.unwrap(value);
        if (ceArray.length > 0) {
            var names = [];
            for (var i = 0; i < ceArray.length; i++) {
                names.push(ceArray[i].name);
            }
            $(element).attr("placeholder", "Начните набирать Ф.И.О. ...");
            var typeahead = $(element).data('typeahead');
            if (typeahead) {
                typeahead.source = names;
            } else {
                $(element).typeahead({
                    source: names,
                    items: 6,
                    //updater: viewModel.onAppSelected
                });
            }
        }
    }
}

ko.bindingHandlers.loginEnter = {
    init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        $(element).on("keydown", function (event) {
            if (event.keyCode == 13) {
                viewModel.validate();
            }
            else {
                return;
            }
        });
    },
    update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        var value = ko.unwrap(valueAccessor());
    }
};

ko.bindingHandlers.showModal = {
    init: function (element, valueAccessor) {
        $(element).modal({
            show: false,
            keyboard: false,
            backdrop: "static"
        });

        var value = valueAccessor();
        if (ko.isObservable(value)) {
            $(element).on('hide.bs.modal', function (e) {
                if ($(e.target).id == 'modalView') {
                    value(false);
                }
            });
        }
    },
    update: function (element, valueAccessor) {
        var value = valueAccessor();
        if (ko.unwrap(value)) {
            $(element).modal('show');
        } else {
            $(element).modal('hide');
        }
    }
}

ko.bindingHandlers.showConfirmModal = {
    init: function (element, valueAccessor) {
        $(element).modal({
            show: false,
            keyboard: false,
            backdrop: "static"
        });

        var value = valueAccessor();
        if (ko.isObservable(value)) {
            $(element).on('hide.bs.modal', function () {
                value(false);
            });
        }
    },
    update: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var value = valueAccessor();
        if (ko.unwrap(value)) {
            var applyBtn = $(element).find('#applyBtn');
            applyBtn.removeClass();
            applyBtn.addClass("btn " + bindingContext.$data.cnfrmBtn().cssClass);
            applyBtn.html(bindingContext.$data.cnfrmBtn().text);
            $(element).modal('show');
        } else {
            $(element).modal('hide');
        }
    }
}

ko.bindingHandlers['dynhtml'] = {
    'init': function () {
        return { 'controlsDescendantBindings': true };
    },
    'update': function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        ko.utils.setHtml(element, valueAccessor());
        ko.applyBindingsToDescendants(bindingContext, element);
    }
};

ko.bindingHandlers.numeric = {
    init: function (element) {
        $(element).on("keydown", function (event) {
            // Allow: backspace, delete, tab, escape, and enter
            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
                // Allow: Ctrl+A
                (event.keyCode == 65 && event.ctrlKey === true) ||
                // Allow: -
            ($(this).val().indexOf('-') >= 0 === false && this.selectionStart == 0 && (event.keyCode == 189 || event.keyCode == 109)) ||
                // Allow: home, end, left, right
                (event.keyCode >= 35 && event.keyCode <= 39) ||
                //reload page
                event.keyCode == 116 ||
                event.ctrlKey && event.keyCode == 82) {
                // let it happen, don't do anything
                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                    event.preventDefault();
                }
            }
        });
    }
};

ko.bindingHandlers.unumeric = {
    init: function (element) {
        $(element).on("keydown", function (event) {
            // Allow: backspace, delete, tab, escape, and enter
            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
                // Allow: Ctrl+A
                (event.keyCode == 65 && event.ctrlKey === true) ||
                // Allow: home, end, left, right
                (event.keyCode >= 35 && event.keyCode <= 39) ||
                //reload page
                event.keyCode == 116 ||
                event.ctrlKey && event.keyCode == 82) {
                // let it happen, don't do anything
                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                    event.preventDefault();
                }
            }
        });
    }
};

ko.bindingHandlers.urangenumeric = {
    init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        var val = valueAccessor();
        $(element).on("keyup", function (event) {
            // Allow: backspace, delete, tab, escape, and enter
            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
                // Allow: Ctrl+A
                (event.keyCode == 65 && event.ctrlKey === true) ||
                // Allow: home, end, left, right
                (event.keyCode >= 35 && event.keyCode <= 39) ||
                //reload page
                event.keyCode == 116 ||
                event.ctrlKey && event.keyCode == 82) {
                // let it happen, don't do anything
                if (parseInt(ko.unwrap(val.modelValue)) < val.min) {
                    val.modelValue(val.min);
                }
                console.log(ko.unwrap(val.modelValue));
                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                    event.preventDefault();
                }
            }
        });

        $(element).on("keydown", function (event) {
            // Allow: backspace, delete, tab, escape, and enter
            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
                // Allow: Ctrl+A
                (event.keyCode == 65 && event.ctrlKey === true) ||
                // Allow: home, end, left, right
                (event.keyCode >= 35 && event.keyCode <= 39) ||
                //reload page
                event.keyCode == 116 ||
                event.ctrlKey && event.keyCode == 82) {
                // let it happen, don't do anything
                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                    event.preventDefault();
                }
                else {
                    if (parseInt(ko.unwrap(val.modelValue) + String.fromCharCode(event.keyCode - (event.keyCode >= 96 ? 48 : 0))) > val.max) {
                        event.preventDefault();
                    }
                    if (parseInt(ko.unwrap(val.modelValue)) < val.min) {
                        event.preventDefault();
                    }
                    console.log(ko.unwrap(val.modelValue) + String.fromCharCode(event.keyCode - (event.keyCode >= 96 ? 48 : 0)));
                }
            }
        });
    }
};

ko.bindingHandlers.year = {
    init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        $(element).on("keydown", function (event) {
            var year = ko.unwrap(valueAccessor());
            if (event.keyCode == 27 || event.keyCode == 13) {
                viewModel.hideEditYear();
                viewModel.onChangeMonth(0);
                return;
            }
            // Allow: backspace, delete
            if (event.keyCode == 46 || event.keyCode == 8 ||
                // Allow: Ctrl+A
                (event.keyCode == 65 && event.ctrlKey === true) ||
                // Allow: home, end, left, right
                (event.keyCode >= 35 && event.keyCode <= 39) ||
                //reload page
                event.keyCode == 116 ||
                event.ctrlKey && event.keyCode == 82) {
                // let it happen, don't do anything
                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                    event.preventDefault();
                }
            }
        });
    }
};

ko.bindingHandlers.doubleNumeric = {
    init: function (element) {
        $(element).on("keydown", function (event) {
            if ($(element).val().indexOf(',') >= 0) {
                var val = $(element).val();
                $(element).val(val.replace(',', '.'));
            }
            // Allow: backspace, delete, tab, escape, and enter
            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
                // Allow: Ctrl+A
                (event.keyCode == 65 && event.ctrlKey === true) ||
                // Allow: -
            ($(this).val().indexOf('-') >= 0 === false && this.selectionStart == 0 && (event.keyCode == 189 || event.keyCode == 109)) ||
                // Allow: ,
            ($(this).val().indexOf('.') >= 0 === false && $(this).val().length > 0 && (event.keyCode == 190 || event.keyCode == 110)) ||
                // Allow: home, end, left, right
                (event.keyCode >= 35 && event.keyCode <= 39) ||
                //reload page
                event.keyCode == 116 ||
                event.ctrlKey && event.keyCode == 82) {
                // let it happen, don't do anything
                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                    event.preventDefault();
                }
            }
        });
    }
};

ko.bindingHandlers.udoubleNumeric = {
    init: function (element) {
        $(element).on("keydown", function (event) {
            if ($(element).val().indexOf(',') >= 0) {
                var val = $(element).val();
                $(element).val(val.replace(',', '.'));
            }
            // Allow: backspace, delete, tab, escape, and enter
            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
                // Allow: Ctrl+A
                (event.keyCode == 65 && event.ctrlKey === true) ||
                // Allow: .
            ($(this).val().indexOf('.') >= 0 === false && $(this).val().length > 0 && (event.keyCode == 190 || event.keyCode == 110)) ||
                // Allow: home, end, left, right
                (event.keyCode >= 35 && event.keyCode <= 39) ||
                //reload page
                event.keyCode == 116 ||
                event.ctrlKey && event.keyCode == 82) {
                // let it happen, don't do anything

                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                    event.preventDefault();
                }
            }
        });
    }
};

ko.bindingHandlers.executeOnEnter = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
        var allBindings = allBindingsAccessor();
        $(element).on("keydown", (function (event) {
            var keyCode = (event.which ? event.which : event.keyCode);
            if (keyCodeIsUNumber(keyCode, event.shiftKey, event.ctrlKey)) {
                if (keyCode === 13) {
                    allBindings.executeOnEnter.call(viewModel, viewModel, true);
                    return false;
                } else if (keyCode === 27) {
                    allBindings.executeOnEnter.call(viewModel, viewModel);
                }
                return true;
            } else {
                event.preventDefault();
            }
        }));
    }
};

ko.bindingHandlers.appExecuteOnEnter = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
        var allBindings = allBindingsAccessor();
        $(element).on("keydown", (function (event) {
            var keyCode = (event.which ? event.which : event.keyCode);
            if (keyCode === 13) {
                allBindings.appExecuteOnEnter.call(viewModel, viewModel, true);
                return false;
            } else if (keyCode === 27) {
                allBindings.appExecuteOnEnter.call(viewModel, viewModel);
            }
            return true;
        }));
    }
};

ko.bindingHandlers.yearExecuteOnEnter = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
        var allBindings = allBindingsAccessor();
        $(element).on("keydown", (function (event) {
            var val = $(element).val();
            var keyCode = (event.which ? event.which : event.keyCode);
            if ((val.length < 4 && keyCodeIsUNumber(keyCode, event.shiftKey, event.ctrlKey)) ||
                    (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
                // Allow: Ctrl+A
                    (event.keyCode == 65 && event.ctrlKey === true) ||
                // Allow: home, end, left, right
                    (event.keyCode >= 35 && event.keyCode <= 39) ||
                //reload page
                    event.keyCode == 116 ||
                    event.ctrlKey && event.keyCode == 82)) {
                if (keyCode === 13) {
                    allBindings.yearExecuteOnEnter.call(viewModel, viewModel);
                    return false;
                } else if (keyCode === 27) {
                    allBindings.yearExecuteOnEnter.call(viewModel, viewModel);
                }
                return;
            }
            else {
                event.preventDefault();
            }
        }));
    }
};

ko.bindingHandlers.drawLineChart = {
    init: function () {
        return { 'controlsDescendantBindings': true };
    },
    update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        var graphData = ko.unwrap(valueAccessor());
        var data = {
            labels: [],
            datasets: []
        };
        var allDates = [];
        if (graphData && graphData.dates.length > 1) {
            var dates = [];
            for (var i = 0; i < graphData.dates.length; i++) {
                dates.push(graphData.dates[i]);
            }
            dates[dates.length - 1] = graphData.dates[graphData.dates.length - 1];
            allDates = dates.slice();
            if (dates.length > 20) {
                for (var i = 0; i < dates.length; i++) {
                    if (i % 2 != 0)//not multiply of 2
                    {
                        if (dates[i].indexOf("00:00") >= 0 && i + 1 < dates.length)
                            dates[i + 1] = dates[i].substring(0, dates[i].indexOf("00:00")) + dates[i + 1];
                        dates[i] = "";
                    }
                }
            }
            data.labels = dates;
            var pointAreaColor = "#fff";
            for (var i = 0; i < graphData.app.length; i++) {
                var values = [];
                for (var k = 0; k < graphData.app[i].values.length; k++) {
                    if (graphData.app[i].values[k] != null) {
                        values[k] = graphData.app[i].values[k];
                    }
                }
                data.datasets.push(
                    {
                        fillColor: chartColor.highlightFillColor(i),
                        strokeColor: chartColor.highlightLineColor(i),
                        pointColor: chartColor.highlightLineColor(i),
                        pointStrokeColor: pointAreaColor,
                        pointHighlightFill: pointAreaColor,
                        pointHighlightStroke: chartColor.highlightLineColor(i),
                        data: values,
                        title: graphData.app[i].name
                    }
                );
            }
        }

        var anotateLableFunc = function (area, ctx, data, statData, posi, posj, othervars) {
            return "<%='<b>" + allDates[posj] + "</b><br />' + v1 + ': <b>' + v3 + '</b>'%>";
        }

        var options = {
            annotateDisplay: true,
            responsive: true,
            responsiveMaxHeight: 300,
            responsiveMinHeight: 210,
            legend: true,
            legendPosX: 4,
            legendPosY: 1,
            legendBorders: false,
            maxLegendCols: 1,
            legendFontSize: 14,
            legendFontFamily: "'Helvetica Neue'",
            legendFontStyle: "normal normal",
            legendFontColor: "rgba(0,0,0,1)",
            legendSpaceBetweenBoxAndText: 5,
            legendSpaceBetweenTextHorizontal: 5,
            rotateLabels: 90,
            annotateDisplay: true,
            annotateLabel: anotateLableFunc,
            yAxisMinimumInterval: 10,
            graphMax: 100,
            scaleShowGridLines: false,
            segmentShowStroke: true,
            segmentStrokeWidth: 2,
            segmentStrokeColor: "rgba(255,255,255,1.00)",
            datasetStroke: true,
            datasetFill: false,
            datasetStrokeWidth: 1,
            bezierCurve: true,
            pointDotStrokeWidth: 1,
            pointDotRadius: 3,
            pointDot: true,
            pointDotMarker: "circle",
            pointHitDetectionRadius: 5,
            scaleShowLabelBackdrop: true,
            animationEasing: 'easeInOutCubic',
            animateRotate: true,
            animateScale: false,
            animationByDataset: false,
            animationLeftToRight: true,
            animationSteps: 50,
            animation: true
        };



        var canvas = $(element).find("#lineChart").get(0);
        canvas.width = element.clientWidth;
        canvas.height = 300;
        var ctx = canvas.getContext("2d");
        var myNewChart = new Chart(ctx).Line(data, options);
    }
};


ko.bindingHandlers.drawBarChart = {
    init: function () {
        return { 'controlsDescendantBindings': true };
    },
    update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        var value = ko.unwrap(valueAccessor());
        if (!value || bindingContext.$parent.dates.length > 0) {
            return;
        }
        var arr = [];
        var dataset = viewModel.dataset();
        var colors = [0, 1, 6, 2, 4, 9, 11];
        for (var i = 0; i < dataset.length; i++) {
            arr.push(
                {
                    fillColor: chartColor.lineColor(colors[i]),
                    strokeColor: chartColor.lineColor(colors[i]),
                    data: dataset[i].data,
                    title: dataset[i].name
                }
            );
        }
        var data = {
            labels: ko.utils.arrayMap(ko.unwrap(bindingContext.$parent.dates), function (item) {
                return item.substring(item.length - 5);
            }),
            datasets: arr
        };

        var options = {
            spaceLeft: -8,
            spaceRight: -22,
            spaceTop: 20,
            //show data in graph
            inGraphDataShow: true,
            inGraphDataYPosition: 3,
            inGraphDataVAlign: computeInGraphVAlign,
            inGraphDataPaddingY: computeInGraphPaddingY,
            inGraphDataTmpl: "<%=(v3 > 0 ? v3 : '')%>",
            inGraphDataFontColor: computeInGraphFontColor,

            //legend
            legend: true,
            legendPosX: 1,
            legendXPadding: 20,
            legendBorders: true,
            legendBordersWidth: 1,

            //animation
            animation: true,
            animationEasing: 'easeInQuart',
            animateRotate: true,
            animateScale: false,
            animationByDataset: false,
            animationLeftToRight: false,
            animationSteps: 50,

            //scales
            scaleShowGridLines: false,
            scaleShowLine: false,
            barValueSpacing: 0,
            yAxisLeft: false,
            rotateLabels: 90,

            //anotation
            annotateDisplay: true,
            annotateLabel: "<%=v1+' - '+v3+' ('+v6+'%)'%>",

            //responsive
            responsive: true,
            responsiveMaxHeight: 300,
            responsiveMinHeight: 210
        };

        function computeInGraphVAlign(area, ctx, data, statData, posi, posj, othervars) {
            if (1 * data.datasets[posi].data[posj] == 1) return ("bottom");
            else return ("top");
        }

        function computeInGraphPaddingY(area, ctx, data, statData, posi, posj, othervars) {
            if (1 * data.datasets[posi].data[posj] == 1) return (1);
            else return (-1);
        }

        function computeInGraphFontColor(area, ctx, data, statData, posi, posj, othervars) {
            if (data.datasets[posi].data[posj] > 1 &&
                (data.datasets[posi].fillColor === chartColor.lineColor(colorsEnum.blue) ||
                data.datasets[posi].fillColor === chartColor.lineColor(colorsEnum.oliva) ||
                data.datasets[posi].fillColor === chartColor.lineColor(colorsEnum.red) ||
                data.datasets[posi].fillColor === chartColor.lineColor(colorsEnum.black)))
                return ("white");
            else
                return ("black");
        }

        var canvas = $(element).find('canvas').get(0);
        canvas.width = element.clientWidth;
        canvas.height = 300;
        var ctx = canvas.getContext("2d");
        var myNewChart = new Chart(ctx).StackedBar(data, options);
    }
};

ko.bindingHandlers.drawPieChart = {
    init: function () {
        return { 'controlsDescendantBindings': true };
    },
    update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        var val = valueAccessor();
        if (val.a() && val.b()) {
            var data = [];
            data.push(
                {
                    value: Math.abs(parseFloat(val.a())),
                    color: chartColor.lineColor(colorsEnum.blue),
                    highlight: chartColor.highlightLineColor(colorsEnum.blue),
                }
            );
            if (val.a() < 100) {
                var fValue = parseFloat(val.b());
                data.push(
                    {
                        value: Math.abs(fValue),
                        color: chartColor.lineColor(fValue >= 0 ? colorsEnum.green : colorsEnum.red),
                        highlight: chartColor.highlightLineColor(fValue >= 0 ? colorsEnum.green : colorsEnum.red),
                    }
                );
            }

            var anotateLableFunc = function (area, ctx, data, statData, posi, posj, othervars) {
                var label = '';
                var value = 'v2';
                if (posi == 1) {
                    label = 'Boni/Mali';
                    value = (viewModel.avgBoniMali() > 0 ? '+' : '') + viewModel.avgBoniMali();
                } else if (posi == 0) {
                    label = 'caption' in viewModel ? viewModel.caption : viewModel.rootApiClass();
                }
                return "<%= '" + label + ": <b>' + " + value + " + '</b>' %>";
            }

            var options = {
                //responsive: true,
                annotateDisplay: true,
                annotateLabel: /*"<%=v2 %>"*/anotateLableFunc,
                animationSteps: 50
            };
            var canvas = $(element).find("#pieChart").get(0);
            canvas.width = 110;
            canvas.height = 110;
            var ctx = $(element).find("#pieChart").get(0).getContext("2d");
            var pieChart = new Chart(ctx).Pie(data, options);
        }
    }
};

ko.bindingHandlers.drawIncidentPieChart = {
    init: function () {
        return { 'controlsDescendantBindings': true };
    },
    update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        var val = ko.unwrap(valueAccessor());
        if (val && val.length > 0) {
            var data = [];
            var colors = [0, 1, 6, 2, 4, 9, 11];
            for (var i = 0; i < val.length; i++) {
                data.push(
                    {
                        value: ko.unwrap(val[i].nrincidents),
                        color: chartColor.highlightLineColor(colors[i]),
                        highlight: chartColor.highlightLineColor(colors[i]),
                        title: val[i].name
                    }
                );
            }

            var options = {
                responsive: true,
                responsiveMaxHeight: 250,
                responsiveMinHeight: 250,
                annotateLabel: "<%=v1 + ' - ' + v2 + ' (' + v6 + '%)'%>",
                legend: true,
                maxLegendCols: 1,
                legendBlockSize: 15,
                legendFillColor: 'rgba(255,255,255,0.00)',
                legendColorIndicatorStrokeWidth: 1,
                legendPosX: 4,
                legendPosY: 2,
                legendXPadding: 0,
                legendYPadding: 0,
                legendBorders: false,
                legendBordersWidth: 1,
                legendBordersColors: "rgba(102,102,102,1)",
                legendBordersSpaceBefore: 5,
                legendBordersSpaceLeft: 5,
                legendBordersSpaceRight: 5,
                legendBordersSpaceAfter: 5,
                legendSpaceBeforeText: 5,
                legendSpaceLeftText: 5,
                legendSpaceRightText: 5,
                legendSpaceAfterText: 5,
                legendSpaceBetweenBoxAndText: 5,
                legendSpaceBetweenTextHorizontal: 5,
                legendSpaceBetweenTextVertical: 5,
                legendFontFamily: "'Open Sans'",
                legendFontStyle: "normal normal",
                legendFontColor: "rgba(0,0,0,1)",
                legendFontSize: 15,
                annotateDisplay: true,
                animationSteps: 50
            };
            var canvas = $(element).find("#pieChartIncident").get(0);
            canvas.width = element.clientWidth;
            canvas.height = 250;
            var ctx = $(element).find("#pieChartIncident").get(0).getContext("2d");
            var pieChart = new Chart(ctx).Pie(data, options);
        }
    }
};

ko.bindingHandlers.dateSelector = {
    init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        $(element).datepicker({
            format: "dd.mm.yyyy",
            autohide: true,
            todayHighlight: true,
            startDate: new Date(2014, 10, 1),
            weekStart: 1,
            todayBtn: true
        });
        var val = ko.unwrap(valueAccessor());
        $(element).datepicker('setDate', val);
        $('#dayPicker').on('click', function () {
            $(element).datepicker('show');
        });
    }
};

ko.bindingHandlers.timeSelector = {
    init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        $(element).timepicker({
            minuteStep: 5,
            defaultTime: '00:00',
            appendWidgetTo: 'body',
            showSeconds: false,
            showInputs: true,
            showMeridian: false
        });
    },
    update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        var val = ko.unwrap(valueAccessor());
    }
}

ko.bindingHandlers.dateTimeSelector = {
    init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        $(element).datetimepicker({
            weekStart: 1,
            todayBtn: 0,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            forceParse: 0,
            showMeridian: 0,
            fontAwesome: true,
            format: 'dd.mm.yyyy hh:ii'
        });
    },
    update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        var val = ko.unwrap(valueAccessor());
    }
}

ko.bindingHandlers.multiDateOfWeekSelector = {
    init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        $(element).find($('.dropdown-menu')).click(function (e) {
            e.stopPropagation();
        });
    }
};

ko.bindingHandlers.multiDateSelector = {
    init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        $(element).datepicker({
            multidate: true,
            format: "dd",
            autohide: true,
            todayHighlight: true,
            startDate: new Date(2014, 10, 1),
            weekStart: 1,
            todayBtn: true
        });
        var val = ko.unwrap(valueAccessor());
        var arr = [];
        var now = new Date();
        for (var i = 0; i < val.length; i++) {
            arr.push(new Date(now.getFullYear(), now.getMonth(), val[i]));
        }
        $(element).datepicker('setDates', arr);
        $('#daysPicker').on('click', function () {
            $(element).datepicker('show');
        });
    },
    update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        /*var val = ko.unwrap(valueAccessor());
        $(element).datepicker('setDates', val.join(','));*/
    }
};

ko.bindingHandlers.enableToolTips = {
    init: function () {
        var obj = $('[data-toggle="tooltip"]');
        $("body").tooltip({ selector: '[data-toggle=tooltip]', html: true });
    }
};

var responsableTableOnResize = function (element, val) {
    $("#periodTable").removeClass('partwidth');
    $("#periodTable").removeClass('allwidth');
    $("#periodTable").addClass(element.clientWidth > (val * 37 - 37) ? 'partwidth' : 'allwidth');
};

ko.bindingHandlers.responsableTable = {
    init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        var id;
        $(window).resize(function () {
            clearTimeout(id);
            var val = 0;
            var vm = viewModel;
            if (viewModel.rootApiItems().length > 0) {
                val = viewModel.dates().length;
            }
            id = setTimeout(responsableTableOnResize(element, val), 100);
        });
    },
    update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        var val = ko.unwrap(valueAccessor());
        if (val > 0) {
            responsableTableOnResize(element, val);
        }
    }
};

ko.bindingHandlers.responsableCalendar = {
    init: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        viewModel.afterRenderCalendar();
    },
    update: function (element, valueAccessor, allBindings, viewModel, bindingContext) {
        viewModel.afterRenderCalendar();
    }
};