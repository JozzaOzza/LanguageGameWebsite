import React, { useEffect, useState } from 'react';

// variables
let ignore = false

// other components
function Header({ title }) {
  return <h1>{title ? title : 'Default title'}</h1>;
}

// main component
export default function HomePage() {
  
  // states

  const [words, setWords] = useState([[]])
  const [hide, setHide] = useState(true)

  useEffect(() => {
    console.log(`First word in list is: ${words[0][0]}`);
  }, [words])

  // functions

  function getData(topic) {
    fetch(`http://localhost:5000/api/${topic}`).then(
      Response => Response.json()
    ).then(
      Data => {
        console.log(Data.words)
        setWords(Data.words)
      }
    )
  }

  function callDbScript(topic) {
    fetch(`http://localhost:5000/api/db`).then(
      Response => Response.json()
    ).then(
      Data => {
        console.log(Data.words)
      }
    )
  }

  function startSession(topic) {
    getData(topic)
    setHide(false)
  }

  // html

  return (
    
    <div>
      
      <Header title="My Italian Website Project" />
      
      <div>The aim of this project is to create a website where you can practice vocab learning in a foreign language</div> <br />
      <div>Currently, the only supported language is Italian</div> <br />
      <div>Words are taken from 
        {" "}  
         <a href="https://www.fluentin3months.com/italian-words/#h-the-100-most-used-italian-nouns-20-more-nouns-you-need-to-know">this website</a>
      </div> <br />
      <button id='nounsButton' onClick={() => {
          document.getElementById("nounsButton").style.display="none"
          document.getElementById("verbsButton").style.display="none"
          startSession("nouns")
        }}>Nouns</button> 
      {" "}
      <button id='verbsButton' onClick={() => {
          document.getElementById("nounsButton").style.display="none"
          document.getElementById("verbsButton").style.display="none"
          startSession("verbs")
        }}>Verbs</button>
      {" "}
      <button id='dbButton' onClick={() => {
          callDbScript()
        }}>Data</button> <br /> <br />  
      <>{!hide && <Session id='session' words={words} style=''/>}</>  

    </div>

  );
}