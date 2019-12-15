import React from 'react';

import Highcharts from 'highcharts'
import addSankeyModule from 'highcharts/modules/sankey'
import addDependencyWheelModule from 'highcharts/modules/dependency-wheel'
import HC_exporting from 'highcharts/modules/exporting'
import HighchartsReact from 'highcharts-react-official'

addSankeyModule(Highcharts);
addDependencyWheelModule(Highcharts);
HC_exporting(Highcharts);

const DependancyWheel = (props) => {
    const myData = props.data.map((item) => {
        return [item.to, item.from, item.weight]
    });
    const options = {

        title: {
            text: 'Dependencies for ' + props.name
        },
    
        accessibility: {
            point: {
                descriptionFormatter: function (point) {
                    var index = point.index + 1,
                        from = point.from,
                        to = point.to,
                        weight = point.weight;
    
                    return index + '. From ' + from + ' to ' + to + ': ' + weight + '.';
                }
            }
        },
    
        series: [{
            keys: ['from', 'to', 'weight'],
            data: myData,
            type: 'dependencywheel',
            name: 'Dependencies',
            dataLabels: {
                color: '#333',
                textPath: {
                    enabled: true,
                    attributes: {
                        dy: 5
                    }
                },
                distance: 10
            },
            size: '100%'
        }]
    
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

export default DependancyWheel;