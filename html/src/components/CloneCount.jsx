import React from 'react';
import Card from 'react-bootstrap/Card'


const CloneCount = (props) => {
    return (
        <Card>
            <Card.Header>
                <h2>{props.count1} / {props.count2}</h2>
            </Card.Header>
            <Card.Body>
                <p>clones detected</p>
                <p><i>(type 1 / type 2)</i></p>
            </Card.Body>
        </Card>
    );
}

export default CloneCount;