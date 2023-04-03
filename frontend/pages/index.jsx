import React, { useEffect, useState } from 'react';

// variables
let ignore = false

// other components
function Header({ title }) {
  return <h1>{title ? title : 'Default title'}</h1>;
}

function QuestionsTest({ questions }) {
  return <p>{questions ? questions : 'No questions have loaded'}</p>
}

function Session({ questionsLoaded }) {
  return <div>
    {(questionsLoaded === false) ? (
      <p>Data is still loading ...</p>
    ) : (
      <><div>Type out the word in Italian which means "{question[0]}"</div> <br />  
      <input type="text" id="attempt" onChange={updateAnswer} value={answer} autoComplete="off"></input > 
      <button onClick={clearText}>Clear</button> <br /><br /> 
      <button onClick={submitAnswer}>Click to submit your answer</button> <br /><br />
      <div >{result}</div> <br />
      <button onClick={newQuestion}>Click to receive a new word</button></>
  ) }
  </div>
}

// main component
export default function HomePage() {
  
  // states

  const [question, setQuestion] = useState(null)
  const [words, setWords] = useState(null)
  const [answer, setAnswer] = useState('')
  const [result, setResult] = useState('')
  const [hide, setHide] = useState(true)

  // functions

  function getData() {

  }

  function startSession() {
    getData()
    setHide(false)
  }

  function updateAnswer(event) {
    setAnswer(event.target.value)
  }

  function submitAnswer() {
    setResult(answer.toLowerCase() == question[1] ?
    "Congratulations, you were correct" :
    "Not quite, try again :)");
  }

  function clearText() {
    setAnswer("")
    setResult("");
  }

  function newQuestion() {
    clearText()
    setQuestion(words[Math.floor(Math.random() * words.length)])
    console.log(`New question is: ${question[1]}`)
  }

  // html

  return (
    
    <div>
      
      <Header title="My Italian Website Project" />
      
      <div>The aim of this project is to create a website where you can practice vocab learning in a foreign language</div> <br />
      <div>Currently, the only supported language is Italian</div> <br />
      <div>Did it work?</div> <br /> <br />

      <QuestionsTest words={words} />

      {(hide === true) ? (
        <button onClick={startSession()}>Start</button>
      ) : (
        <Session questionsLoaded={false}/>
      )}

    </div>

  );
}