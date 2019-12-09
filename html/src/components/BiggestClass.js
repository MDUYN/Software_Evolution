import React, { useState } from 'react';
import Card from 'react-bootstrap/Card';
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';

const BiggestClass = (props) => {
    const [showCode, setShowCode] = useState(false);

    const handleCloseCode = () => setShowCode(false);
    const handleShowCode = () => setShowCode(true);
    const [showSummary, setShowSummary] = useState(false);

    const handleCloseSummary = () => setShowSummary(false);
    const handleShowSummary = () => setShowSummary(true);
    var i =0;
    const items = props.data.map((item) => 
        <li key={i++}>{item.path} (from line: {item.begin[0]} -> to line: {item.end[0]})</li>);

    return (
        <>
            <Card>
                <Card.Header>
                    <h2>
                        {props.length}
                    </h2>
                </Card.Header>
                <Card.Body>
                    <p>
                        entries in the biggest clone class.
                    </p>
                    <p>
                    <Button variant="primary" onClick={handleShowCode}>
                        Show code
                    </Button>
                    </p>
                    <p></p>
                    <Button variant="primary" onClick={handleShowSummary}>
                        Show summary
                    </Button>
                </Card.Body>
            </Card>
            <Modal size="lg"
                aria-labelledby="contained-modal-title-vcenter"
                centered
                show={showCode} onHide={handleCloseCode}>
                <Modal.Header closeButton>
                    <Modal.Title>{props.path}</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <pre><code>
                        {props.content}
                    </code></pre>
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={handleCloseCode}>
                        Close
           </Button>
                </Modal.Footer>
            </Modal>

            <Modal size="lg"
                aria-labelledby="contained-modal-title-vcenter"
                centered
                show={showSummary} onHide={handleCloseSummary}>
                <Modal.Header closeButton>
                    <Modal.Title>Clone class summary</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <ul>
                        {items}
                    </ul>
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={handleCloseSummary}>
                        Close
           </Button>
                </Modal.Footer>
            </Modal>
        </>
    );
}

export default BiggestClass;