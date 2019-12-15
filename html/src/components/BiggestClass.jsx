import React, { useState } from 'react';
import Card from 'react-bootstrap/Card';
import ButtonGroup from 'react-bootstrap/ButtonGroup';
import DropdownButton from 'react-bootstrap/DropdownButton'
import Dropdown from 'react-bootstrap/Dropdown'

const BiggestClass = (props) => {
    const handleOnClick = e => props.onClick(e);
    var i = 0;
    const summary = (data) => data.map((item) =>
        <li key={i++}>{item.path} (from line: {item.begin[0]} -> to line: {item.end[0]})</li>);
    
    return (
        <Card>
            <Card.Header>
                <h2>
                    {props.dataType1.length} / {props.dataType2.length}
                </h2>
            </Card.Header>
            <Card.Body>
                <p>
                    entries in the biggest clone class.
                    </p>
                <ButtonGroup>
                    <DropdownButton as={ButtonGroup} title="Type1" id="bg-nested-dropdown">
                        <Dropdown.Item eventKey="1" 
                            onClick = {
                                () => {
                                    handleOnClick({
                                        "content": props.dataType1[0].content, 
                                        "path": "Example of class from: " + props.dataType1[0].path
                                    });
                                }
                            }
                        >
                            Code
                        </Dropdown.Item>
                        <Dropdown.Item eventKey="2" 
                            onClick = {
                                () => {
                                    handleOnClick({   
                                        "content": summary(props.dataType1), 
                                        "path": "summary"
                                    });
                                }
                            }
                        >
                            Summary
                        </Dropdown.Item>
                    </DropdownButton>
                    <DropdownButton as={ButtonGroup} title="Type2" id="bg-nested-dropdown2">
                        <Dropdown.Item eventKey="1" 
                            onClick = {
                                () => {
                                    handleOnClick({
                                        "content": props.dataType2[0].content, 
                                        "path": "Example of class from: " + props.dataType2[0].path
                                    });
                                }
                            }
                        >
                            Code
                        </Dropdown.Item>
                        <Dropdown.Item eventKey="2" 
                            onClick = {
                                () => {
                                    handleOnClick({   
                                        "content": summary(props.dataType2), 
                                        "path": "summary"
                                    });
                                }
                            }
                        >
                            Summary
                        </Dropdown.Item>
                    </DropdownButton>
                </ButtonGroup>
            </Card.Body>
        </Card>
    );
}

export default BiggestClass;