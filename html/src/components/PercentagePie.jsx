import React from 'react';
import Card from 'react-bootstrap/Card';

import Highcharts from 'highcharts'
import HighchartsReact from 'highcharts-react-official'


const PercentagePie = (props) => {
    const duplication = props.percentage;
    const rest = 100 - props.percentage;

    const options = {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'total duplication for ' + props.name
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                }
            }
        },
        series: [{
            name: 'Percentage ' + props.name,
            colorByPoint: true,
            data: [{
                name: 'Duplication',
                y: duplication,
                sliced: true,
                selected: true
            }, {
                name: 'Rest',
                y: rest
            }]
        }
    ]
    };
    return (
        <Card>
            <Card.Header>
                <h1>{props.percentage}%</h1>
            </Card.Header>
            <Card.Body>
                <HighchartsReact
                    highcharts={Highcharts}
                    options={options}
                />
            </Card.Body>
        </Card>
    );
}

export default PercentagePie;