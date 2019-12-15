import React from 'react';

import Highcharts from 'highcharts'
import HighchartsReact from 'highcharts-react-official'

const Density = (props) => {
    const keys = props.type2.sort().map((item) => item.name);
    const values = [0,props.type1[0].count, props.type1[1].count, 0];
    const values2 = props.type2.map((item) => item.count);
    const options = {
        chart: {
            type: 'column' 
        },
        title: {
            text: 'Clones per package'
        },
        xAxis: {
            categories: keys,
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: 'No of clones'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f} clones</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [
            { name: "type1", data:values},
            { name: "type2", data:values2}
        ]
    }
    return (
        <div>
            <HighchartsReact
                highcharts={Highcharts}
                options={options}
            />
        </div>
    );
}

export default Density;