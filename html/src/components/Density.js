import React, { useState } from 'react';
import Card from 'react-bootstrap/Card'
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';

import { VerticalBarSeries, XYPlot, VerticalGridLines, HorizontalGridLines, XAxis, YAxis } from 'react-vis';

const Density = (props) => {
    const myData = props.data.map((item) => {
        return { x: item.name, y: item.count }
    });

    const [show, setShow] = useState(false);

    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);
    return (
        <>
            <Card>
                <Card.Header className="cardHeader">
                    <h1>Clones found per package</h1>
                </Card.Header>
                <Card.Body>
                    <XYPlot margin={{ bottom: 70 }} xType="ordinal" width={300} height={300}>
                        <VerticalGridLines />
                        <HorizontalGridLines />
                        <XAxis />
                        <YAxis />
                        <VerticalBarSeries
                            data={myData}
                        />
                    </XYPlot>
                </Card.Body>
            </Card>
            <Modal
                size="lg"
                aria-labelledby="contained-modal-title-vcenter"
                centered
                show={show} onHide={handleClose}>
                <Modal.Header closeButton>
                    <Modal.Title>Distribution graph</Modal.Title>
                </Modal.Header>
                <Modal.Body>

                </Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={handleClose}>
                        Close
    </Button>
                </Modal.Footer>
            </Modal>
        </>
    );
}

export default Density;