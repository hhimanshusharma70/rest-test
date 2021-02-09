import React, { useEffect, useState } from 'react';
import axios from 'axios';
import './App.css';
import List from './components/List';
import withListLoading from './components/withListLoading';

function App() {
  const ListLoading = withListLoading(List);
  const [appState, setAppState] = useState({
    loading: false,
    repos: null,
  });

  useEffect(() => {
    setAppState({ loading: true }); 
    /** */
    const apiUrl = `http://ec2-13-232-192-86.ap-south-1.compute.amazonaws.com:9100/api/v1/test/list`;
    axios.get(apiUrl).then((repos) => {
      const allRepos = repos.data;
      setAppState({ loading: false, repos: allRepos });
    });
  }, [setAppState]);
  return (
    <div className='App'>
      <div className='container'>
        <h1>Test 09-Feb-2021</h1>
      </div>
      <div className='repo-container'>
        <ListLoading isLoading={appState.loading} repos={appState.repos} />
      </div>
      <footer>
        <div className='footer'>
          Tests{' '}
          <span role='img' aria-label='love'>
            💚
          </span>{' '}
          with by Test11
        </div>
      </footer>
    </div>
  );
}

export default App;
