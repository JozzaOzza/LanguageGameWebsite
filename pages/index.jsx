import { useState } from 'react';
function Header({ title }) {
  return <h1>{title ? title : 'Default title'}</h1>;
}

export default function HomePage() {
  
  // states
  const names = ['Jamie', 'Orr', 'Project'];
  const [word, setWord] = useState('');
  const [result, setResult] = useState('')
  
  // functions
  function textTyping(event) {
    setWord(event.target.value);
  }
  function wordSubmit() {
    setResult(word.toLowerCase() == "ciao" ?
    "Congratulations, you were correct" :
    "Not quite, try again :)");
  }
  function clearText() {
    setWord("");
    setResult("");
  }

  // html
  return (
    
    <div>
      <Header title="My Italian Website Project" />
      <ul>
        {names.map((name) => (
          <li key={name}>{name}</li>
        ))}
      </ul>
      

      <div>Type out the Italian for 'Hello', and submit your answer</div> <br />  
      <input type="text" id="hello" name="hello" onChange={textTyping} value={word} autoComplete="off"></input > <button onClick={clearText}>Clear</button> <br /><br /> 
      <button onClick={wordSubmit}>Click to submit your answer</button> <br /> <br />
      <div>{result}</div>

      <br></br><br></br>
    </div>

  );
}