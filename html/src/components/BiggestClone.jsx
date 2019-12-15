import React from 'react';
import Card from 'react-bootstrap/Card';
import Button from 'react-bootstrap/Button';

const BiggestClone = (props) => {
    const handleOnClick = e => props.onClick(e);

    return (
            <Card>
                <Card.Header>
                    <h2>
                        {props.type1.length} / {props.type2.length}
                    </h2>
                </Card.Header>
                <Card.Body>
                    <p>
                        lines in the biggest clone
                    </p>
                    <Button variant="primary" onClick={() => handleOnClick({
                        "content": props.type1.content,
                        "path": props.type1.path
                    })}>
                        Type 1
                    </Button>
                    <Button variant="primary" onClick={() => handleOnClick({
                        "content": props.type2.content,
                        "path": props.type2.path
                    })}>
                        Type 2
                    </Button>
                </Card.Body>
            </Card>
    );
}

export default BiggestClone;