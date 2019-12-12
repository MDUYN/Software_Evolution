import React from 'react';
import Nav from 'react-bootstrap/Nav'

const SideBar = (props) => {
    var id = 0;
    const children = props.children.map((child) => {
        return (
            <div key={"navItem" + id++}>
                <Nav.Item>
                    {child}
                </Nav.Item>
                <hr />
            </div>
        )
    });
    return (
        <Nav className={"col-md-2 d-none d-md-block bg-light sidebar"}>
                <h1 className="sidebar-header">{props.title}</h1>
                <div className="sidebar-sticky">
                    <ul className="nav flex-column">
                        {children}
                    </ul>
                </div>
        </Nav>
    );
}

export default SideBar;