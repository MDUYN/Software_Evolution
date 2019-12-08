import React, { useState } from 'react';
import Card from 'react-bootstrap/Card'
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';

import { RadialChart} from 'react-vis';

const PercentagePie = (props) => {
    const myData = [{ angle: props.percentage }, { angle: (100 - props.percentage) }]
    const [show, setShow] = useState(false);

    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);
    return (
        <>
        <Card>
            <Card.Header className="cardHeader">
                <h1>{props.percentage}%</h1>
            </Card.Header>
            <Card.Body>
                <p>duplication found in the project.</p>
                <Button variant="primary" onClick={handleShow}>
                        Show graph
                </Button>
            </Card.Body>
        </Card>
         <Modal size="lg"
         aria-labelledby="contained-modal-title-vcenter"
         centered
         show={show} onHide={handleClose}>
         <Modal.Header closeButton>
             <Modal.Title>Duplication graph</Modal.Title>
         </Modal.Header>
         <Modal.Body>
         <RadialChart
                    data={myData}
                    width={200}
                    height={200} />
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

export default PercentagePie;