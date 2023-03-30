import { useEffect, useState } from 'react';

function Header({ title }) {
  return <h1>{title ? title : 'Default title'}</h1>;
}

const wordList = [["hello", "ciao"], ["however", "ciononostante"], ["but", "ma"], ["and", "e"], ["after", "dopo"]]

export default function HomePage() {
  
  // states

  const [answer, setAnswer] = useState('')
  const [question, setQuestion] = useState(wordList[0])
  const [result, setResult] = useState('')
  
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
    setQuestion(wordList[Math.floor(Math.random() * wordList.length)])
  }

  // html

  return (
    
    <div>
      
      <Header title="My Italian Website Project" />
      
      <div>The aim of this project is to create a website where you can practice vocab learning in a foreign language</div> <br />
      <div>Currently, the only supported language is Italian</div> <br />
      <div>Once we've figured out one langauge, then maybe we can think about extending to more</div> <br /> <br />
      
      <div>Type out the word in Italian which means "{question[0]}"</div> <br />  
      <input type="text" id="attempt" onChange={updateAnswer} value={answer} autoComplete="off"></input > 
      <button onClick={clearText}>Clear</button> <br /><br /> 
      <button onClick={submitAnswer}>Click to submit your answer</button> <br /> <br />
      <div >{result}</div> <br />
      <button onClick={newQuestion}>Click to receive a new word</button>

    </div>

  );
}