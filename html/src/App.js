import React, { Component } from 'react';
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import './App.css';
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
          this.setState({isLoading : false});
          console.log(data);
        })
  }

  render() {
    if(this.state.isLoading) return null;
    const { data } = this.state;
    const {biggestClone: bc} = data;
    const {biggestClass: bic} = data;
    return (
      <Container className="p-3">
        <Row>
          <Col>
            <PercentagePie percentage={data.percentage} />
          </Col>
          <Col>
            <CloneCount count={data.numberOfClones}/>
          </Col>
          <Col>
            <BiggestClone length = {bc.length} path = {bc.path} content={bc.content}/>
          </Col>
          <Col>
            <BiggestClass data={bic} length = {bic.length} path = {bic[0].path} content={bic[0].content}/>
          </Col>
        </Row>
        <Row>
          <Col>
            <Density data = {data.packageDensity}></Density>
          </Col>
        </Row>
      </Container>
    );
  }
}

export default App;