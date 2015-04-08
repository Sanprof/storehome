var recordsPerPage = [10, 20, 50, 100, 99999];

var chartColor = {
    colors: [
          //gray
          "167,179,188",
          //green
          "124,180,124",
          //blue
          "37,119,181",
          //orange
          "240,173,78",
          //oliva
          "156,88,0",
          //purple
          "127,85,255",
          //red
          "217,83,79",
          //see wave
          "13,183,141",
          //black
          "90,90,90",
          //
          "175,175,5",
          //yellow
          "255,255,0",
          //orange2
          "252,188,104",
    ],
    lineColor: function (index) {
        return "rgba(" + chartColor.colors[index] + ",0.8)"
    },
    highlightLineColor: function (index) {
        return "rgba(" + chartColor.colors[index] + ",1)"
    },
    fillColor: function (index) {
        return "rgba(" + chartColor.colors[index] + ",0.5)"
    },
    highlightFillColor: function (index) {
        return "rgba(" + chartColor.colors[index] + ",0.75)"
    }
};

var colorsEnum = {
    gray: 0,
    green: 1,
    blue: 2,
    orange: 3,
    oliva: 4,
    purple: 5,
    red: 6,
    see_wave: 7,
    black: 8,
    system: 9
};

var appTypesConstant = [
    {
        id: 3,
        name: 'Web Applications'
    },
    {
        id: 2,
        name: 'Non Web Applications'
    }
];