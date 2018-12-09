import QtQuick 2.0
import "QChart.js" as Charts
Canvas {
    id: canvas;
    property   var chart;
    property   var chartData;
    property   int chartType: 0;
    property  bool chartAnimated: true;
    property alias chartAnimationEasing: chartAnimator.easing.type;
    property alias chartAnimationDuration: chartAnimator.duration;
    property   int chartAnimationProgress: 0;
    property   var chartOptions: ({})
    onPaint: {
        var ctx = canvas.getContext("2d");
        ctx.reset()
        switch(chartType) {
        case Charts.ChartType.BAR:
            chart = new Charts.Chart(canvas, ctx).Bar(chartData, chartOptions);
            break;
        case Charts.ChartType.DOUGHNUT:
            chart = new Charts.Chart(canvas, ctx).Doughnut(chartData, chartOptions);
            break;
        case Charts.ChartType.LINE:
            chart = new Charts.Chart(canvas, ctx).Line(chartData, chartOptions);
            break;
        case Charts.ChartType.PIE:
            chart = new Charts.Chart(canvas, ctx).Pie(chartData, chartOptions);
            break;
        case Charts.ChartType.POLAR:
            chart = new Charts.Chart(canvas, ctx).PolarArea(chartData, chartOptions);
            break;
        case Charts.ChartType.RADAR:
            chart = new Charts.Chart(canvas, ctx).Radar(chartData, chartOptions);
            break;
        default:
            console.log('Chart type should be specified.');
        }
        chart.init();
        if (chartAnimated)
            chartAnimator.start();
        else
            chartAnimationProgress = 100;
        chart.draw(chartAnimationProgress/100);
    }
    onHeightChanged: {
        requestPaint();
    }
    onWidthChanged: {
        requestPaint();
    }
    onChartAnimationProgressChanged: {
        requestPaint();
    }
    onChartDataChanged: {
        requestPaint();
    }
    function repaint() {
        chartAnimationProgress = 0;
        chartAnimator.start();
    }
    PropertyAnimation {
        id: chartAnimator;
        target: canvas;
        property: "chartAnimationProgress";
        to: 100;
        duration: 500;
        easing.type: Easing.InOutElastic;
    }
}
