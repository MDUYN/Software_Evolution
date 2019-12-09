import React, {useState} from 'react';
import Card from 'react-bootstrap/Card';
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';

const BiggestClone = (props) => {
    const [show, setShow] = useState(false);

  const handleClose = () => setShow(false);
  const handleShow = () => setShow(true);
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
                        lines in the biggest clone
                    </p>
                    <Button variant="primary" onClick={handleShow}>
                        Show code
                </Button>
                </Card.Body>
            </Card>
            <Modal size="lg"
                    aria-labelledby="contained-modal-title-vcenter"
                    centered
                    show={show} onHide={handleClose}>
                <Modal.Header closeButton>
                    <Modal.Title>{props.path}</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <pre><code>
                        {props.content}
                    </code></pre>
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

export default BiggestClone;