import React from 'react';
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';


const CustomModal = (props) => {
    const handleClose = () => props.onClose();
    return (
        <Modal size="lg"
            aria-labelledby="contained-modal-title-vcenter"
            centered
            show={props.show} onHide={handleClose}>
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
    );
}

export default CustomModal;