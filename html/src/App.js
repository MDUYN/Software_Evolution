import React, { Component } from 'react';
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'

import Header from './components/Header'

import SideBar from './components/SideBar'
import CloneCount from './components/CloneCount'
import BiggestClone from './components/BiggestClone'
import BiggestClass from './components/BiggestClass';

import Density from './components/Density'
import PercentagePie from './components/PercentagePie'
import DependancyWheel from './components/DependencyWheel';

import CustomModal from './components/CustomModal'


import './App.css';

class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      isLoading: true,
      content: "",
      showModal: false
    };
  }

  componentDidMount() {
    Promise.all([
      fetch('http://localhost:8080/type1').then(res => res.json()),
      fetch('http://localhost:8080/type1/dep').then(res => res.json()),
      fetch('http://localhost:8080/type2').then(res => res.json()),
      fetch('http://localhost:8080/type2/dep').then(res => res.json())
    ])
      .then(data => {
        this.setState({ dataType1: data[0] });
        this.setState({ dependenciesType1: data[1] });
        this.setState({ dataType2: data[2] });
        this.setState({ dependenciesType2: data[3] });
        this.setState({ isLoading: false });
        console.log(this.state.dataType1.biggestClass);
      });
  }

  handleContent = (data) => {
    console.log(data);
    this.setState({ modalContent: data.content })
    this.setState({ modalPath: data.path })
    this.setState({ showModal: true })
  }

  handleClose = () => this.setState({ showModal: false })


  render() {
    if (this.state.isLoading) return null;
    const {dataType1, dataType2, 
          dependenciesType1, dependenciesType2, 
          showModal, modalPath, modalContent} = this.state;
    return (
      <>
        <Header name="smallsql" />
        <Container fluid={true}>
          <Row>
            <SideBar title="Quick Stats">
              <CloneCount count1={dataType1.numberOfClones} count2={dataType2.numberOfClones} />
              <BiggestClone onClick={this.handleContent} type1={dataType1.biggestClone} type2={dataType2.biggestClone} />
              <BiggestClass onClick={this.handleContent} dataType1={dataType1.biggestClass} dataType2={dataType2.biggestClass} />
            </SideBar>
            <Col md={9} lg={10} className="pt-3 px-4">
              <Density type1={dataType1.packageDensity} type2={dataType2.packageDensity}></Density>
              <hr />
              <Row>
                <Col>
                  <DependancyWheel name="type1" data={dependenciesType1}></DependancyWheel>
                </Col>
                <Col>
                  <DependancyWheel name="type2" data={dependenciesType2}></DependancyWheel>
                </Col>
              </Row>
              <hr />
              <Row>
                <Col>
                  <PercentagePie name="type1" percentage={dataType1.percentage} />
                </Col>
                <Col>
                  <PercentagePie name="type2" percentage={dataType2.percentage} />
                </Col>
              </Row>
            </Col>
          </Row>
        </Container>
        <CustomModal show={showModal} path={modalPath} content={modalContent} onClose={this.handleClose} />
      </>
    );
  }

}

export default App;