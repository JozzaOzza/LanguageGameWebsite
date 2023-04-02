import React, { useEffect, useState } from 'react';

function Header({ title }) {
  return <h1>{title ? title : 'Default title'}</h1>;
}

export default function HomePage() {
  
  // states

  const [words, setWords] = useState()
  const [answer, setAnswer] = useState('')
  const [question, setQuestion] = useState()
  const [result, setResult] = useState('')
  
  useEffect(() => {
    async function fetchMyAPI() {
      let response = await fetch('/api')
      response = await response.json()
      setWords(await response['words'])
      console.log(words)
      setQuestion(words[Math.floor(Math.random() * words.length)])
    }

    fetchMyAPI()
  }, [])

  // functions

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

      
      {(typeof question === 'undefined' || question === []) ? (
        <p>Data is loading...</p>
      ) : (
        <><div>Type out the word in Italian which means "{question[0]}"</div> <br />  
        <input type="text" id="attempt" onChange={updateAnswer} value={answer} autoComplete="off"></input > 
        <button onClick={clearText}>Clear</button> <br /><br /> 
        <button onClick={submitAnswer}>Click to submit your answer</button> <br /><br />
        <div >{result}</div> <br />
        <button onClick={newQuestion}>Click to receive a new word</button></>
      )}

    </div>

  );
}