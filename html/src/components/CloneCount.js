import React from 'react';
import Card from 'react-bootstrap/Card'


const CloneCount = (props) => {
    return (
        <Card>
            <Card.Header>
                <h2>{props.count}</h2>
            </Card.Header>
            <Card.Body>
                clones detected
            </Card.Body>
        </Card>
    );
}

export default CloneCount;