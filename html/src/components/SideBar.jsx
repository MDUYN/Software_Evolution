import React from 'react';
import Nav from 'react-bootstrap/Nav'

const SideBar = (props) => {
    const children = props.children.map((child) => {
        return (
            <>
            <Nav.Item>
                {child}
            </Nav.Item>
            <hr/>
            </>);
    });
    return (
        <Nav className={"col-md-2 d-none d-md-block bg-light sidebar"}>
            <div class="sidebar-sticky">
                <ul class="nav flex-column">
                    {children}
                </ul>
            </div>
        </Nav>
    );
}

export default SideBar;