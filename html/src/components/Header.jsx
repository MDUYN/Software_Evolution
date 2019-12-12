import React from 'react';
import Navbar from 'react-bootstrap/Navbar'

const Header = (props) => (
    <Navbar variant="dark" bg="dark" className="justify-content-md-center">
        <Navbar.Brand href="#">Clone detection for {props.name}</Navbar.Brand>
    </Navbar>
)

export default Header;