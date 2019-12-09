import React, { Component } from 'react';
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import './App.css';
import SideBar from './components/SideBar'
import PercentagePie from './components/PercentagePie'
import CloneCount from './components/CloneCount'
import BiggestClone from './components/BiggestClone'
import BiggestClass from './components/BiggestClass'
import Density from './components/Density';

class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      isLoading: true
    };
  }

  componentDidMount() {
    fetch('http://localhost:8080')
      .then(res => res.json())
      .then((data) => {
        this.setState({ data: data })
        this.setState({ isLoading: false });
        console.log(data);
      })
  }

  render() {
    if (this.state.isLoading) return null;
    const { data } = this.state;
    const { biggestClone: bc } = data;
    const { biggestClass: bic } = data;
    return (
      <Container fluid={true}>
        <Row>
          <SideBar>
            <CloneCount count={data.numberOfClones} />
            <PercentagePie percentage={data.percentage} />
            <BiggestClone length={bc.length} path={bc.path} content={bc.content} />
            <BiggestClass data={bic} length={bic.length} path={bic[0].path} content={bic[0].content} />
          </SideBar>
        <Col md={9} lg={10} className="pt-3 px-4">
          <Density data = {data.packageDensity}></Density>
        </Col>
        </Row>
      </Container>
    );
  }

}

export default App;