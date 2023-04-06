import React, { useEffect, useState } from 'react';

// variables
let ignore = false

// other components
function Header({ title }) {
  return <h1>{title ? title : 'Default title'}</h1>;
}

function Session({words}) {

  // states
  const [question, setQuestion] = useState([])  
  const [answer, setAnswer] = useState('')
  const [result, setResult] = useState('')
  const [score, setScore] = useState([0, 0])
  const [submitOn, setSubmitOn] = useState(true)
  const [questionTime, setQuestionTime] = useState(false)

  // useEffect(() => {
  //   console.log(`Current question is: ${question[0]}`);
  // }, [question])

  // functions
  function updateAnswer(event) {
    setAnswer(event.target.value)
  }

  function submitAnswer() {
    setResult(answer.toLowerCase() == question[1] ?
    "Congratulations, you were correct" :
    "Not quite, try again :)"
    )
    setScore(answer.toLowerCase() == question[1] ? 
    [score[0] + 1, score[1] + 1] :
    [score[0], score[1] + 1]
    )
    setSubmitOn(true)
  }

  function clearText() {
    setAnswer("")
    setResult("");
  }

  function newQuestion() {
    clearText()
    setQuestion(words[Math.floor(Math.random() * words.length)])
    setQuestionTime(true)
    setSubmitOn(false)
  }

  function goHome() {
    
  }

  // render
  return <div>
    {(words === [[]]) ? (
      <p>Data is still loading ...</p>
    ) : (
      <>
      <div>{(!questionTime) ?
      "Press the New Question button to get started" : 
      `Type out the word in Italian which means "${question[0]}"`
      }</div> <br />  
      <input type="text" id="attempt" onChange={updateAnswer} value={answer} autoComplete="off"></input >
      {" "} 
      <button disabled={submitOn} onClick={clearText}>Clear</button> <br /><br /> 
      <button id='submitButton' disabled={submitOn} onClick={submitAnswer}>Submit Answer</button>
      {"      "} 
      <button onClick={newQuestion}>New Question</button> <br /> <br />
      <button onClick={newQuestion}>Back</button> <br /> <br />
      <div>Your current score is: {score[0]} / {score[1]}</div> <br />
      <p >{(result === "") ? 
      " " :
      result
      }</p> <br />
      </>

  ) }
  </div>
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
        }}>Verbs</button> <br /> <br />  
      <>{!hide && <Session id='session' words={words} style=''/>}</>  

    </div>

  );
}